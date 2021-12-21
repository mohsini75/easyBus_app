import 'dart:io' show Platform;
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

import 'qr_scan.dart';
import '/users/student/dashboard.dart';
import 'package:flutter/material.dart';

class StudentBottomTabScreen extends StatefulWidget {
  static final routeName = "sbt";
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<StudentBottomTabScreen> {
  //get driver and student data
  DriverLocation driver_ = new DriverLocation();
  StudentLocation student = new StudentLocation();

  //use to control the bottom bar

  PageController? _pageController;

// for qr scanning
  String scanResult = "demo scan";
  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

// for adding trnasaction
  final User? user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  CollectionReference add_transaction =
      FirebaseFirestore.instance.collection('transactions');

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  int _currentIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await FirebaseAuth.instance.signOut();
        return Future.value(true);

        // return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.black12,
            elevation: 0,
            onPressed: () {
              _scan();
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //   return add_transaction();
              // }));
            },
            child: const Icon(
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
              const StudentChatHome(),
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
          items: const <Widget>[
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
          // onTap: (index) {
          //   setState(() {
          //     _pageController!.jumpToPage(index);
          //   });
          // },
          onTap: (tabIndex) {
            setState(() {
              _currentIndex = tabIndex;
            });
            _pageController!.jumpToPage(tabIndex);
          },
          //currentIndex: _currentIndex,
          letIndexChange: (index) => true,
        ),
      ),
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
        ),
      );
      final stringResult = result.rawContent;

      setState(() {
        scanResult = stringResult;
        print(scanResult);
      });
    } catch (e) {
      scanResult = "Error scanning.Try again";
    }
    if (scanResult.contains("sucessful")) {
      print("object------------------------------------------------------");
      FirebaseFirestore.instance
          .collection("users")
          .where('id', isEqualTo: user!.uid)
          .snapshots()
          .first
          .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        var extractedMap = querySnapshot.docs.first.data();
        addSTransaction(extractedMap["id"]);
      });

      // addSTransaction(user!.uid);
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(
          'Transaction Added...',
        ),
        duration: Duration(seconds: 2),
      ));
      print("1111111111111111111111111111111111111111111111111111111111111");
    } else {
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(
          'Failed to make transaction. Try again',
        ),
        duration: Duration(seconds: 4),
      ));
    }
  }

  Future<void> addSTransaction(String id) {
    print("add studentr wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    //print(textController.text);
    return add_transaction
        .add({"id": id, "Date": DateTime.now()})
        .then((value) => print(" Added student transaction"))
        .catchError((error) => print("Failed : $error"));
  }
}
