import 'package:demo/services/chatHome.dart';
import 'package:demo/services/google_map.dart';
import 'package:demo/users/driver/Test/driverLocation.dart';
import 'package:demo/users/driver/view_driver_profile.dart';
import 'package:demo/users/student/student_notifications.dart';
import 'package:demo/users/student/view_users_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'drawer.dart';

import '/users/student/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DriverNavbar extends StatefulWidget {
  static final routeName = "dbt";
  const DriverNavbar({Key? key}) : super(key: key);

  @override
  _DriverNavbarState createState() => _DriverNavbarState();
}

class _DriverNavbarState extends State<DriverNavbar> {
  DriverLocation d = new DriverLocation();
  @override
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
        body: PageView(
            controller: _pageController,
            children: <Widget>[
              DriverDrawer(),
              ViewUserScreen("student"),
              GoogleMapLocationScreen(d.currentLocation),
              ChatHome(),
              ViewDriverProfile()
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
              Icons.home,
              size: 30,
              color: Colors.deepPurple,
            ),
            Icon(
              Icons.list,
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
          //color: Colors.white60,
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
