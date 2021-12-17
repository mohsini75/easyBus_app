import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demo/services/chatHome.dart';

import 'package:demo/services/live_map.dart';
import 'package:demo/users/driver/Test/driverLocation.dart';
import 'package:demo/users/driver/Test/studentLocation.dart';
import 'package:demo/users/driver/view_driver_profile.dart';
import 'package:demo/users/student/add_transaction.dart';
import 'package:demo/users/student/studentChatHome.dart';
import 'package:demo/users/student/view_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './/users/student/drawer.dart';
import './/users/student/student_notifications.dart';

import '/users/student/QR_scan.dart';
import '/users/student/dashboard.dart';
import 'package:flutter/material.dart';

class StudentBottomTabScreen extends StatefulWidget {
  static final routeName = "sbt";
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<StudentBottomTabScreen> {
  DriverLocation driver_ = new DriverLocation();
  StudentLocation student = new StudentLocation();
  int _page = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await FirebaseAuth.instance.signOut();
        return Future.value(true);

        // return true;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.black12,
            elevation: 0,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return add_transaction();
              }));
            },
            child: Icon(
              Icons.qr_code_2_rounded,
              size: 40,
            )),
        body: PageView(
            controller: _pageController,
            children: <Widget>[
              DrawerApp(),
              MapScreen(
                currentLocation: student.currentLocation,
                destinationLocation: driver_.currentLocation,
              ),
              StudentChatHome(),
              ViewProfile()
              //Friends(),
              //Profile(),
            ],
            onPageChanged: (int index) {
              setState(() {
                _pageController!.jumpToPage(index);
              });
            }),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(
              Icons.dashboard_outlined,
              size: 30,
              color: Colors.deepPurple,
            ),
            Icon(
              Icons.near_me_sharp,
              size: 30,
              color: Colors.deepPurple,
            ),
            Icon(
              Icons.chat_bubble,
              size: 30,
              color: Colors.deepPurple,
            ),
            Icon(
              Icons.perm_identity,
              size: 30,
              color: Colors.deepPurple,
            ),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.purple.shade200,
          backgroundColor: Colors.blue.shade400,
          animationCurve: Curves.fastLinearToSlowEaseIn,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _pageController!.jumpToPage(index);
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
