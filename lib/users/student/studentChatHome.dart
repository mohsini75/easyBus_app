import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/chatRoom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentChatHome extends StatefulWidget {
  const StudentChatHome({Key? key}) : super(key: key);

  @override
  _StudentChatHomeState createState() => _StudentChatHomeState();
}

class _StudentChatHomeState extends State<StudentChatHome> {
  String? thisStudentRoute;
  String? thisStudentDriverID;
  Map<String, dynamic>? driverMap;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        // setState(() {
        thisStudentRoute = documentSnapshot['route'];
        print(documentSnapshot['name']);
        // });
      } else {
        print("Driver document not found");
      }
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .where('route', isEqualTo: thisStudentRoute)
          .where('role', isEqualTo: 'driver')
          .snapshots()
          .first
          .
          // .doc(FirebaseAuth.instance.currentUser!.uid)

          then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        // if (documentSnapshot.exists) {
        // setState(() {
        var extractedMap = querySnapshot.docs.first.data();
        // thisStudentRoute = extractedMap[''];
        thisStudentDriverID = extractedMap['id'];

        // setState(() {
        driverMap = {
          "id": extractedMap['id'],
          "name": extractedMap['name'],
          "email": extractedMap['email'],
        };

        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => ChatRoom(
                    chatRoomId: chatRoomId(
                        FirebaseAuth.instance.currentUser!.uid,
                        thisStudentDriverID!),
                    userMap: driverMap!,
                  )),
        );
      });
    });
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
