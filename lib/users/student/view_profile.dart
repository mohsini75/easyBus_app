import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final User? user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamData() {
    return _firestore
        .collection("users")
        .where('id', isEqualTo: user!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: streamData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs[0];

                  return Column(
                    children: [
                      Stack(children: [
                        Container(
                          width: size.width,
                          height: size.height * 0.24,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Colors.blue.shade200,
                                Colors.purple.shade100
                              ],
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter)),
                          child: Column(
                            children: [
                              Container(
                                height: 30,
                              ),
                              CircleAvatar(
                                  radius: 50, child: Icon(Icons.contact_mail)
                                  //Image.asset(""),
                                  //backgroundColor: Colors.transparent,
                                  ),
                              Text(
                                data['name'], //snapshot.data!['name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2),
                              ),
                              Text(data['email'],
                                  style: TextStyle(
                                      fontSize: 16, letterSpacing: 2)),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.app_registration_rounded),
                        title: Text('Registration Number'),
                        subtitle: Text(data['regNo'].toString().toUpperCase()),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Contact Number'),
                        subtitle: Text(data['contact']),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.add_road_rounded),
                        title: Text('Route Name'),
                        subtitle: Text(data['address']),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.airport_shuttle_rounded),
                        title: Text('Route No.'),
                        subtitle: Text(data['routeNo']),
                      ),
                      Divider(),
                      ListTile(
                          leading: Icon(Icons.money),
                          title: Text('Fee Clearance'),
                          subtitle: data['feeClearance'] == 'false'
                              ? Text(
                                  "Unpaid",
                                  style: TextStyle(color: Colors.red),
                                )
                              : Text(
                                  "Paid",
                                  style: TextStyle(color: Colors.green),
                                )),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
