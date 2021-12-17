import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class add_transaction extends StatefulWidget {
  const add_transaction({Key? key}) : super(key: key);

  @override
  _add_transactionState createState() => _add_transactionState();
}

class _add_transactionState extends State<add_transaction> {
  final User? user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  //String? id;

  CollectionReference add_transaction =
      FirebaseFirestore.instance.collection('transaction');

  Future<void> addStudentComplain(String id) {
    print("add studentr wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    //print(textController.text);
    return add_transaction
        .add({"student_id": id, "Date": DateTime.now()})
        .then((value) => print(" Added student transaction"))
        .catchError((error) => print("Failed : $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          FlatButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("users")
                    .where('id', isEqualTo: user!.uid)
                    .snapshots()
                    .first
                    .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
                  var extractedMap = querySnapshot.docs.first.data();
                  addStudentComplain(extractedMap["id"]);
                });
              },
              child: Center(child: Text("add transaction"))),
        ],
      )),
    );
    //SnackBar(content: Text("Transaction added"));
  }
}
