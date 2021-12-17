import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/notification_databse.dart';
import 'package:flutter/material.dart';

class AllComplainScreen extends StatefulWidget {
  AllComplainScreen({Key? key}) : super(key: key);

  @override
  _AllComplainScreenState createState() => _AllComplainScreenState();
}

class _AllComplainScreenState extends State<AllComplainScreen> {
  DatabseNotifcation database = new DatabseNotifcation();
  final Stream<QuerySnapshot> s_Complains =
      FirebaseFirestore.instance.collection('studentComplains').snapshots();
  final Stream<QuerySnapshot> d_Complains =
      FirebaseFirestore.instance.collection('driverComplains').snapshots();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.purple.shade400,
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
            title: const Text(
              'Complaints Panel',
              style: TextStyle(letterSpacing: 3),
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: database.StreamStudentComplain(
                    s_Complains, "routeNo", "regNo", "comment"),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: database.StreamDriverComplain(
                    d_Complains, "regNo", "comment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
