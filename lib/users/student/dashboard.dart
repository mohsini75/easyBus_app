import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/google_map.dart';
import 'package:demo/services/live_map.dart';
import 'package:demo/users/driver/Test/driverLocation.dart';
import 'package:demo/users/driver/Test/studentLocation.dart';
import 'package:demo/users/student/student_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/users/student/drawer.dart';
import 'package:flutter/material.dart';
//import '../providers/transaction.dart';

class StudentDashboard extends StatefulWidget {
  static final routeName = "/student_dashboard";
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  DriverLocation driver_ = new DriverLocation();
  StudentLocation student = new StudentLocation();

  Map<String, dynamic>? userMap;
  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .first
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          Map<String, dynamic>? userMap = querySnapshot.docs.first.data();
        });
      });
      //print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              child: Container(
                height: size.height * 0.35,
                width: size.width * 0.9,
                child: MapScreen(
                  currentLocation: student.currentLocation,
                  destinationLocation: driver_.currentLocation,
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            Container(
              height: size.height * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Smartphone 03.jpg')),
                //fit: BoxFit.scaleDown,
              ),
            ),
            Text(
              "Route Information",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  letterSpacing: 3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 30,
                ),
                Container(
                  height: size.height * 0.18,
                  width: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Colors.blue.shade200,
                        Colors.purple.shade100
                      ])),
                ),
                Card(
                  elevation: 4,
                  shadowColor: Colors.purple[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: userMap == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          height: size.height * 0.2,
                          width: size.width * 0.6,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text('Route No: ' + userMap!['routeNo']),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Total Rides : 9'),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Fee Clearance '),
                                  Container(
                                    height: 8,
                                    width: 50,
                                    //color: Colors.green,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color:
                                            userMap!['feeClearance'] == "true"
                                                ? Colors.green
                                                : Colors.red),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
