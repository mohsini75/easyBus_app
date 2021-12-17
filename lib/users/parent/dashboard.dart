import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/live_map.dart';
import '../driver/Test/driverLocation.dart';
import '../driver/Test/studentLocation.dart';

class ParentDashboard extends StatelessWidget {
  DriverLocation driveLoc = new DriverLocation();
  StudentLocation studentLoc = new StudentLocation();
  static const routeName = "/parent_dashboard";

  @override
  Widget build(BuildContext context) {
    void _signOut() {
      Navigator.of(context).pop();
      FirebaseAuth.instance.signOut();
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Parent"),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    //bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(65),
                    bottomRight: Radius.circular(150)),
                gradient: LinearGradient(
                  //transform: GradientRotation(pi / 3),
                  colors: [
                    Colors.purple.shade200,
                    Colors.blue.shade300,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.bottomRight,
                ),
              ),
              height: size.height * 0.35,
              width: double.infinity,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.bus_alert_rounded),
                      Text(
                        'Driver Name',
                      ),
                      SizedBox(height: 20),
                      Text('Route Number'),
                      SizedBox(height: 20),
                      Text('Fee Challan Clearance'),
                      Container(
                        height: 15,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(''),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/icon/ParentDashboardbus.png',
                        height: size.height * 0.2,
                        width: size.width * 0.3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.38),
              ),
              GestureDetector(
                child: ClipRRect(
                  child: Container(
                    height: size.height * 0.4,
                    width: size.width * 0.95,
                    child: MapScreen(
                      currentLocation: studentLoc.currentLocation,
                      destinationLocation: driveLoc.currentLocation,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        currentLocation: studentLoc.currentLocation,
                        destinationLocation: driveLoc.currentLocation,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
