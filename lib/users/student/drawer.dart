import 'package:demo/services/challan.dart';
import 'package:demo/users/student/dashboard.dart';
import 'package:demo/users/student/my_transactions_chart.dart';
import 'package:demo/users/student/rating_feedback.dart';
import 'package:demo/users/student/student_Complain.dart';
import 'package:demo/users/student/student_auth.dart';
import 'package:demo/users/student/student_notifications.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'qr_scan.dart';
import '/users/student/view_profile.dart';
import 'package:flutter/material.dart';
//import '../providers/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class DrawerApp extends StatefulWidget {
  @override
  State<DrawerApp> createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp>
    with SingleTickerProviderStateMixin {
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
                              '',
                              style: TextStyle(letterSpacing: 3),
                            ),
                          ],
                        ),
                      ),
                      // ListTile(
                      //   leading: Icon(Icons.person),
                      //   title: (Text('Profile')),
                      //   onTap: () {
                      //     Navigator.of(context)
                      //         .push(MaterialPageRoute(builder: (context) {
                      //       return ViewProfile();
                      //     }));
                      //   },
                      // ),
                      // Divider(),
                      // ListTile(
                      //   leading: Icon(Icons.scatter_plot_rounded),
                      //   onTap: () {
                      //     // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      //     //   return ScanPage();
                      //     // }));
                      //   },
                      //   title: (Text('Scan')),

                      //   //Navigator.of(context).pushReplacementNamed(OrderScreen.route),
                      // ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.home_rounded,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return StudentComplainScreen();
                          }));
                        },
                        title: (Text('Complaints')),

                        //   Navigator.of(context).pushReplacementNamed(UserProductScreen.route),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.assignment_late_sharp),
                        title: (Text('Rating')),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return RatingScreen();
                          }));
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.list),
                        title: (Text('Transaction')),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return MyTransactionChart();
                          }));
                        },
                      ),
                      Divider(),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.assignment_late_sharp),
                        title: (Text('Fee Challan')),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return Challan();
                          }));
                        },
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.logout_outlined),
                        title: (Text('Log Out')),
                        onTap: () {
                          print("logout");
                          _auth.signOut();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Icon(
                        Icons.view_list_rounded,
                        color: Colors.blue,
                      ),
                      onPressed: () => _controller.toggle(),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.notifications_active,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return StudentNotificationScreen();
                          }));
                        },
                      )
                    ],
                    title: Text(
                      "DashBoard",
                      style: TextStyle(color: Colors.blue, letterSpacing: 3),
                    ),
                  ),
                  body: StudentDashboard(),
                ))));
    // Widget build(BuildContext context) {
    //   return Drawer(
    //     child: Column(
    //       children: [
    //         AppBar(
    //           backgroundColor: Colors.purple[700],
    //           title: Text('Manage'),
    //           automaticallyImplyLeading: false,
    //         ),
    //         Divider(),
    //         ListTile(
    //           leading: Icon(Icons.person),
    //           title: (Text('Profile')),
    //           onTap: () {
    //             Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //               return ViewProfile();
    //             }));
    //           },
    //         ),
    //         Divider(),
    //         ListTile(
    //           leading: Icon(Icons.scatter_plot_rounded),
    //           onTap: () {
    //             // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //             //   return ScanPage();
    //             // }));
    //           },
    //           title: (Text('Scan')),

    //           //Navigator.of(context).pushReplacementNamed(OrderScreen.route),
    //         ),
    //         Divider(),
    //         ListTile(
    //           leading: Icon(
    //             Icons.home_rounded,
    //           ),
    //           onTap: () {},
    //           title: (Text('Dashboard')),

    //           //   Navigator.of(context).pushReplacementNamed(UserProductScreen.route),
    //         ),
    //         Divider(),
    //         ListTile(
    //           leading: Icon(Icons.logout),
    //           onTap: () {
    //             _auth.signOut();

    //             //Navigator.pushReplacementNamed(context, StudentAuth.routeName);
    //           },
    //           title: (Text('Logout')),
    //         )
    //       ],
    //     ),
    //   );
  }
}
