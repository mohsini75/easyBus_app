import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/users/admin/all_complain.dart';
import 'package:demo/users/admin/drawer.dart';
import 'package:demo/users/admin/syn_chart.dart';
import 'package:demo/users/student/view_users_screen.dart';

import 'package:toggle_switch/toggle_switch.dart';

import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  static const routeName = "/admin_dashboard";

  AdminDashboard({Key? key}) : super(key: key);
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool _showChart = false;
  int togValue = 0;
  final textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;

  CollectionReference add_Student_notification =
      FirebaseFirestore.instance.collection('studentNotifications');
  CollectionReference add_Driver_notification =
      FirebaseFirestore.instance.collection('driverNotifications');
  CollectionReference add_Both_notification =
      FirebaseFirestore.instance.collection('bothNotifi');
  void showDailog(String meassage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error Message'),
        content: Text(meassage),
        actions: [
          FlatButton(
            child: Text("okay"),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    try {
      if (!_formKey.currentState!.validate()) {
        // Invalid!
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      // await Provider.of<Auth>(context, listen: false)
      //     .signup(_authData['email'], _authData['password']);
    } on Exception catch (error) {
      showDailog(error.toString());
    } catch (error) {
      showDailog(error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  openAlertBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white10,
            content: SingleChildScrollView(
              child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(
                        0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Colors.purple.shade200,
                      Colors.blue.shade200
                    ], // red to yellow
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "Notifications ",
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.white),
                          ),
                        ]),
                    SizedBox(
                      height: 5.0,
                    ),
                    Divider(
                      color: Colors.purple,
                      height: 4.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            textInputAction: TextInputAction.next,
                            controller: textController,
                            validator: (val) {
                              if (val!.isEmpty || val == null) {
                                return "Cannot be empty";
                              }
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: 8,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type notification'),
                            onSaved: (val) {
                              textController.text = val!;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    ToggleSwitch(
                      minWidth: 80.0,
                      minHeight: 40,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 3,
                      icons: [
                        Icons.person,
                        Icons.settings_accessibility,
                        Icons.people
                      ],
                      iconSize: 30.0,
                      borderWidth: 2.0,
                      borderColor: [Colors.blueGrey],
                      activeBgColors: const [
                        [Colors.blue],
                        [Colors.pink],
                        [Colors.purple]
                      ],
                      onToggle: (index) {
                        togValue = index;
                        print('switched to: $index');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Text(
                            "Create Notification", textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 22),
                            //textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () => {
                              if (togValue == 0)
                                {
                                  addNotiStudent(),
                                  Navigator.of(context).pop(),
                                  textController.clear(),
                                  _submit(),
                                }
                              else if (togValue == 1)
                                {
                                  addNotiDriver(),
                                  Navigator.of(context).pop(),
                                  textController.clear(),
                                  _submit(),
                                }
                              else
                                {
                                  addNotiBoth(),
                                  Navigator.of(context).pop(),
                                  textController.clear(),
                                  _submit(),
                                }
                            }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> addNotiStudent() {
    print("add studentr wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    print(textController.text);
    return add_Student_notification
        .add({
          "message": textController.text,
        })
        .then((value) => print("notification Added student"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addNotiDriver() {
    print("add driver wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    return add_Driver_notification
        .add({
          "message": textController.text,
        })
        .then((value) => print("notification Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addNotiBoth() {
    print("add both wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    return add_Both_notification
        .add({"message": textController.text})
        .then((value) => print("notification Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DASHBOARD',
          style: TextStyle(color: Colors.white, letterSpacing: 3),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notification_add_rounded,
              color: Colors.blue,
              //size: size.width * ,
            ),
            onPressed: () => openAlertBox(),
          ),
        ],
      ),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.4,
              width: size.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/splash_image.PNG"),
                          radius: 15,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Hi, Admin",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      'All Transport',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontSize: 24,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ViewUserScreen("student");
                            }));
                          },
                          child: Column(
                            children: [
                              Text("Student"),
                              Icon(Icons.emoji_people_rounded),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple.shade300,
                            onPrimary: Colors.white,
                            shadowColor: Colors.red,
                            elevation: 5,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Column(
                            children: [
                              Text("Driver"),
                              Icon(Icons.airline_seat_recline_normal_sharp),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple.shade300,
                            onPrimary: Colors.white,
                            shadowColor: Colors.red,
                            elevation: 5,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Column(
                    children: [
                      Text("Bus"),
                      Icon(Icons.directions_bus_rounded),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade300,
                    onPrimary: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AllComplainScreen();
                    }));
                  },
                  child: Column(
                    children: [Text("Complaints"), Icon(Icons.email_outlined)],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade300,
                    onPrimary: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 5,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Show Chart'),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                )
              ],
            ),
            _showChart
                ? Container(
                    height: size.height * 0.3,
                    child: AsynChart(),
                  )
                : Container(
                    child: Text("Switch to show Chart..."),
                  ),
          ],
        ),
      ),
    );
  }
}
