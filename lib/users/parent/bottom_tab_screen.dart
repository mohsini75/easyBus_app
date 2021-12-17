import 'package:demo/services/google_map.dart';
import 'package:demo/services/live_map.dart';
import 'package:demo/users/driver/Test/driverLocation.dart';
import 'package:demo/users/driver/Test/studentLocation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/users/parent/dashboard.dart';
import '/users/parent/parentProfile.dart';
import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class ParentBottomTabScreen extends StatefulWidget {
  static final routeName = "pbt";
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<ParentBottomTabScreen> {
  DriverLocation driveLoc = new DriverLocation();
  StudentLocation studentLoc = new StudentLocation();
  /* final List<Map<String, dynamic>> _pages = [
    {'pages': ParentDashboard(), 'title': "DashBorad"},
    {'pages': null, 'title': "QR Scan"},
    {'pages': null, 'title': "Transactions"},
  ];
  int selectedIndex = 0;

  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[selectedIndex]['title']),
      ),
      body: _pages[selectedIndex]['pages'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedPage,
        unselectedItemColor: Colors.blue[200],
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.purple[100],
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "DashBoard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_2_rounded), label: "Scan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt), label: "Transactions")
        ],
      ),
    );
  }
  */
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await FirebaseAuth.instance.signOut();
        return Future.value(true);

        // return true;
      },
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Container(
                child: ParentDashboard(),
              ),
              Container(
                child: Text("transactions"),
              ),
              Container(
                child: MapScreen(
                  currentLocation: studentLoc.currentLocation,
                  destinationLocation: driveLoc.currentLocation,
                ),
              ),
              Container(
                child: ParentProfileScreen(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(title: Text('Dashboard'), icon: Icon(Icons.home)),
            BottomNavyBarItem(
                title: Text('Transactions'),
                icon: Icon(Icons.view_list_rounded)),
            BottomNavyBarItem(
                title: Text('Location'), icon: Icon(Icons.bus_alert_rounded)),
            BottomNavyBarItem(title: Text('Profile'), icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
