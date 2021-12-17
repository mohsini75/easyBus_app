import 'package:demo/services/notification_databse.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentNotificationScreen extends StatefulWidget {
  const StudentNotificationScreen({Key? key}) : super(key: key);

  @override
  _StudentNotificationScreenState createState() =>
      _StudentNotificationScreenState();
}

class _StudentNotificationScreenState extends State<StudentNotificationScreen> {
  DatabseNotifcation database = new DatabseNotifcation();
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> Snotifications = FirebaseFirestore.instance
        .collection("studentNotifications")
        .snapshots();
    final Stream<QuerySnapshot> Bnotifications = FirebaseFirestore.instance
        .collection('notifications')
        .doc()
        .collection("bothNotifications")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(letterSpacing: 2, color: Colors.blue[300]),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Text("Important Notifications",
              style: TextStyle(
                  letterSpacing: 2, fontSize: 24, fontWeight: FontWeight.w300)),
          SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
              child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: database.StreamCommon(Snotifications, "message"),
              ),
              Text(
                'Easy Bus Portal ',
                style: (TextStyle(
                  letterSpacing: 2,
                )),
              )

              //database.StreamCommon(Bnotifications, "both"),
            ],
          )),
        ],
      ),
    );
  }
}
