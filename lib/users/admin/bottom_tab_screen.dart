import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:demo/services/google_map.dart';
import 'package:demo/users/student/student_notifications.dart';
import 'package:demo/users/student/view_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/users/student/QR_scan.dart';
import '/users/student/dashboard.dart';
import 'package:flutter/material.dart';

class AdminBottomTabScreen extends StatefulWidget {
  static final routeName = "sbt";
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<AdminBottomTabScreen> {
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
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Container();
              }));
            },
            child: Icon(
              Icons.qr_code_2_rounded,
            )),
        body: PageView(
            controller: _pageController,
            children: <Widget>[
              StudentDashboard(),
              //GoogleMapLocationScreen(),
              // Chat1(),
              ViewProfile()
              //Friends(),
              //Profile(),
            ],
            onPageChanged: (int index) {
              setState(() {
                _pageController?.jumpToPage(index);
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
