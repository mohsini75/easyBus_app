import 'package:demo/model/driver.dart';
import 'package:demo/services/google_map.dart';
import 'package:demo/services/live_map.dart';
import 'package:demo/users/driver/Test/DriverLocation.dart';
import 'package:demo/users/driver/driver_notification.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DriverDashboard extends StatefulWidget {
  static final routeName = "/driver_dashboard";
  //const DriverDashboard({Key? key}) : super(key: key);

  @override
  _DriverDashboardState createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  DriverLocation d = new DriverLocation();
  Location location = new Location();
  late Map<String, dynamic> mapData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .where('role', isEqualTo: "driver")
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .first
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      mapData = querySnapshot.docs.first.data();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DashBoard",
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_location_rounded),
            tooltip: "Share Location",
            onPressed: () async {
              d.currentLocation = await location.getLocation();
            },
          )
        ],
      ),
      //drawer: DriverDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Text(
                "Route Number" + mapData['routeNo'],
                style:
                    TextStyle(wordSpacing: 3, letterSpacing: 3, fontSize: 30),
              ),
            ),
            Container(
                width: size.width * 1,
                height: 120,
                child: Image.asset(
                  'assets/images/Person 05.jpg',
                )),
            Divider(),
            Container(
              height: size.height * 0.15,
              //width: size.width * 1,
              //width: double.infinity,
              decoration: BoxDecoration(
                  // image: new DecorationImage(
                  //   image: new ExactAssetImage('assets/images/Person 05.jpg'),
                  //   fit: BoxFit.contain,
                  // ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(130)),
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade300, Colors.blue.shade200],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        mapData['vehicle'],
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        mapData['routeNo'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width * 0.9,
              height: size.height * 0.43,
              child: GoogleMapLocationScreen(d.currentLocation),
            )
          ],
        ),
      ),
    );
  }
}
