// @dart = 2.9
import 'dart:io' show Platform;
import 'package:demo/services/challan_pdf.dart';
import 'package:demo/store_user_role.dart';
import 'package:demo/users/admin/admin_auth.dart';
import 'package:demo/users/driver/bottom_tab_screen.dart';
import 'package:demo/users/driver/driver_auth.dart';
import 'package:demo/users/driver/driver_notification.dart';
import 'package:demo/users/driver/maintenanceReport.dart';
import 'package:demo/users/driver/vehicle_rescue.dart';
import 'package:demo/users/parent/bottom_tab_screen.dart';
import 'package:demo/users/student/QR_scan.dart';
import 'package:demo/users/student/add_transaction.dart';
import 'package:demo/users/student/bottom_tab_screen.dart';
import 'package:demo/users/student/my_transactions_chart.dart';
import 'package:demo/users/student/student_auth.dart';
import 'package:demo/web_app/HomePage.dart';
import 'package:demo/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'users/admin/dashboard.dart';
import 'users/driver/dashboard.dart';
import 'users/parent/dashboard.dart';
import 'users/parent/parent_auth.dart';
import 'users/student/dashboard.dart';
import 'users/student/resgistration_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget selectedWidget;

  @override
  initState() async {
    super.initState();
    if (Platform.isWindows) {
      selectedWidget = const MyHomePage();
    } else {
      if (FirebaseAuth.instance.currentUser != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // await prefs.setString('currentUserRole', role);
        String currentUser = prefs.getString('currentUserRole');
        if (currentUser == 'driver') {
          //  selectedWidget = driverBottomSheet
        } else if (currentUser == 'Student') {}

        // String currentLogInUser = getUserRole() as String;
      } else {
        selectedWidget = WelcomeScreen();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parent ',
      debugShowCheckedModeBanner: false,
      //initialRoute: WelcomeScreen.routeName,
      home: selectedWidget,
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
    );
  }
}

// helo gee coment dekh lo naa
