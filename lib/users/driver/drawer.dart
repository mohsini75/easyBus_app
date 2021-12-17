import 'package:demo/model/driver.dart';
import 'package:demo/services/google_map.dart';
import 'package:demo/users/driver/maintenanceReport.dart';
import 'package:demo/users/driver/vehicle_rescue.dart';
import 'package:demo/users/driver/view_driver_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:location/location.dart';

import 'Test/DriverLocation.dart';
import 'driver_complain.dart';

import 'package:flutter/material.dart';
import 'package:fancy_drawer/fancy_drawer.dart';

import 'driver_notification.dart';

class DriverDrawer extends StatefulWidget {
  const DriverDrawer({Key? key}) : super(key: key);

  @override
  _DriverDrawerState createState() => _DriverDrawerState();
}

class _DriverDrawerState extends State<DriverDrawer>
    with SingleTickerProviderStateMixin {
  DriverLocation d = new DriverLocation();
  late Driver driver;
  Location location = new Location();

  @override
  late FancyDrawerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 150))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple.shade300, Colors.blue.shade100],
                tileMode: TileMode.mirror)),
        child: FancyDrawerWrapper(
          hideOnContentTap: true,
          cornerRadius: 10,
          backgroundColor: Color.fromRGBO(0, 128, 205, 0.15),
          controller: _controller,
          drawerItems: <Widget>[
            Column(
              children: [
                DrawerHeader(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icon/ParentDashboardbus.png",
                        width: 100,
                      ),
                      Text(
                        'Rasheed',
                        style: TextStyle(letterSpacing: 3),
                      ),
                    ],
                  ),
                ),
                // ListTile(
                //   leading: Icon(Icons.person),
                //   title: (Text('View Profile')),
                //   onTap: () {
                //     Navigator.of(context)
                //         .push(MaterialPageRoute(builder: (context) {
                //       return DriverProfileScreen();
                //     }));
                //   },
                // ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.reduce_capacity_outlined),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return vehicleRescueScreen();
                    }));
                  },
                  title: (Text('Vehicle Rescue')),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.receipt_outlined),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MaintenanceReportScreen();
                    }));
                  },
                  title: (Text('Maintenance Report')),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.assignment_late_sharp),
                  title: (Text('Complaint')),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DriverComplainScreen();
                    }));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: (Text('Log Out')),
                  onTap: () {
                    print("logout");
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                Divider(),
              ],
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.view_list_rounded,
                  color: Colors.blue,
                ),
                onPressed: () => _controller.toggle(),
              ),
              title: Text(
                "DashBoard",
                style: TextStyle(color: Colors.blue, letterSpacing: 3),
              ),
              actions: [
                IconButton(
                  iconSize: 30,
                  splashColor: Colors.purple,
                  color: Colors.blue,
                  icon: Icon(Icons.share_location_rounded),
                  tooltip: "Share Location",
                  onPressed: () async {
                    d.currentLocation = await location.getLocation();
                    driver.locationDriver = d.currentLocation;
                    print('${d.currentLocation}'
                        // +
                        //  '${d.currentLocation.longitude}'
                        );
                  },
                ),
                IconButton(
                  iconSize: 30,
                  splashColor: Colors.purple,
                  color: Colors.blue,
                  icon: Icon(Icons.notifications_active),
                  tooltip: "Notification",
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DriverNotificationScreen();
                    }));
                    // +
                    //  '${d.currentLocation.longitude}'
                  },
                ),
              ],
            ),
            //drawer: DriverDrawer(),
            body: Stack(
              children: [
                Column(
                  children: [
                    Card(
                      child: Text(
                        'ROUTE NUMBER: 12',
                        style: TextStyle(
                            wordSpacing: 3, letterSpacing: 3, fontSize: 30),
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
                            colors: [
                              Colors.purple.shade200,
                              Colors.blue.shade200
                            ],
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
                                'Vehicle Number:Acd123',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Driver name: Asad',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                'Inboard Student: 131',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.43,
                      child: GoogleMapLocationScreen(d.currentLocation),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
