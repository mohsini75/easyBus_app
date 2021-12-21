// @dart = 2.9

import 'package:demo/services/challan.dart';

import 'package:demo/services/live_map.dart';
import 'package:demo/users/admin/admin_auth.dart';
import 'package:demo/users/driver/bottom_tab_screen.dart';
import 'package:demo/users/driver/driver_auth.dart';
import 'package:demo/users/driver/driver_notification.dart';
import 'package:demo/users/driver/maintenanceReport.dart';
import 'package:demo/users/driver/vehicle_rescue.dart';
import 'package:demo/users/parent/bottom_tab_screen.dart';
import 'package:demo/users/student/QR_scan.dart';
//import 'package:demo/users/student/qr_scan.dart';
import 'package:demo/users/student/add_transaction.dart';
import 'package:demo/users/student/bottom_tab_screen.dart';
import 'package:demo/users/student/my_transactions_chart.dart';
import 'package:demo/users/student/student_auth.dart';
import 'package:demo/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'users/admin/dashboard.dart';
import 'users/driver/dashboard.dart';
import 'users/parent/dashboard.dart';
import 'users/parent/parent_auth.dart';
import 'users/student/dashboard.dart';
import 'users/student/resgistration_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(new MaterialApp(
    home: new MyApp(),
    routes: {
      WelcomeScreen.routeName: (context) => WelcomeScreen(),
      StudentAuth.routeName: (context) => StudentAuth(),
      AdminAuth.routeName: (context) => AdminAuth(),
      DriverAuth.routeName: (context) => DriverAuth(),
      ParentAuth.routeName: (context) => ParentAuth(),
      RegistrationForm.routeName: (context) => RegistrationForm(),
      // Dashboard Routes
      AdminDashboard.routeName: (context) => AdminDashboard(),
      StudentDashboard.routeName: (context) => StudentDashboard(),
      DriverDashboard.routeName: (context) => DriverDashboard(),
      ParentDashboard.routeName: (context) => ParentDashboard(),
      //RegistrationForm.routeName: (context) => RegistrationForm(),

      StudentBottomTabScreen.routeName: (context) => StudentBottomTabScreen(),
      ParentBottomTabScreen.routeName: (context) => ParentBottomTabScreen(),
      DriverNavbar.routeName: (context) => DriverNavbar(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // initState() async {
  //   super.initState();
  //   // if (Platform.isWindows) {
  //   //   selectedWidget =  WelcomeScreen();
  //   // } else {
  //   //   if (FirebaseAuth.instance.currentUser != null) {
  //   //     SharedPreferences prefs = await SharedPreferences.getInstance();

  //   //     // await prefs.setString('currentUserRole', role);
  //   //     String currentUser = prefs.getString('currentUserRole');
  //   //     if (currentUser == 'driver') {
  //   //       //  selectedWidget = driverBottomSheet
  //   //     } else if (currentUser == 'Student') {}

  //   //     // String currentLogInUser = getUserRole() as String;
  //   //   } else {
  //   //     selectedWidget = WelcomeScreen();
  //   //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new WelcomeScreen(),
      title: new Text(
        'Easy Bus Portal',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, letterSpacing: 2),
      ),
      image: new Image.asset('assets/gifs/Bus driver.gif'),
      photoSize: 200,
      backgroundColor: Colors.white,
      loaderColor: Colors.purple,
    );
  }
}

// helo gee coment dekh lo naa
