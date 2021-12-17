import 'package:demo/users/admin/bottom_tab_screen.dart';
import 'package:demo/users/driver/bottom_tab_screen.dart';
import 'package:demo/users/parent/bottom_tab_screen.dart';
import 'package:demo/users/student/bottom_tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './users/admin/dashboard.dart';
import './users/driver/driver_auth.dart';
import './users/parent/dashboard.dart';
import './users/parent/parent_auth.dart';
import './users/student/dashboard.dart';
import './users/student/student_auth.dart';
import 'package:flutter/material.dart';

import 'users/admin/admin_auth.dart';

class WelcomeScreen extends StatelessWidget {
  static final routeName = "/home";
  Widget loginsButton(
      String text, String shape, IconData icon, Function press) {
    return Row(
      children: [
        Center(
          child: InkWell(
            onTap: () {
              press();
            },
            child: Container(
              // height: 50,
              width: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(
                        0.0,
                        10.0,
                      ),
                      blurRadius: 30,
                      color: Colors.purple.shade100),
                ],
                color: Colors.deepPurple[250], // cahnge to 200 to see changes
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 155,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.purple,
                        ],
                      ),
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(300),
                      ),
                    ),
                  ),
                  Icon(
                    icon,
                    size: 35,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/Travel-BUS-LED.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login As",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                thickness: 2,
                color: Color.fromRGBO(102, 102, 255, 0.7),
              ),
              SizedBox(
                height: 70,
              ),
              loginsButton(
                'Admin',
                '',
                Icons.admin_panel_settings_rounded,
                () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pushNamed(
                        context, AdminBottomTabScreen.routeName);
                  } else {
                    Navigator.pushNamed(context, AdminAuth.routeName);
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              loginsButton(
                'Student',
                '',
                Icons.person,
                () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pushNamed(
                        context, StudentBottomTabScreen.routeName);
                  } else {
                    Navigator.pushNamed(context, StudentAuth.routeName);
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              loginsButton(
                'Parent',
                '',
                Icons.family_restroom_rounded,
                () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pushNamed(
                        context, ParentBottomTabScreen.routeName);
                  } else {
                    Navigator.pushNamed(context, ParentAuth.routeName);
                  }
                },
              ),
              SizedBox(
                height: 50,
              ),
              loginsButton(
                'Driver',
                '',
                Icons.car_rental_rounded,
                () {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pushNamed(context, DriverNavbar.routeName);
                  } else {
                    Navigator.pushNamed(context, DriverAuth.routeName);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
