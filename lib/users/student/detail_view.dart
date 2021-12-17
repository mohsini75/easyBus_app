import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/model/student.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class DetailViewCard extends StatefulWidget {
  //String id;
  final DocumentSnapshot<Object?> snapshot;
  DetailViewCard(@required this.snapshot);

  @override
  _DetailViewCardState createState() => _DetailViewCardState();
}

class _DetailViewCardState extends State<DetailViewCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: size.width,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.blue.shade200,
                    Colors.purple.shade100
                  ], end: Alignment.bottomCenter, begin: Alignment.topCenter)),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                      ),
                      CircleAvatar(radius: 50, child: Icon(Icons.contact_mail)
                          //Image.asset(""),
                          //backgroundColor: Colors.transparent,
                          ),
                      Text(
                        '${widget.snapshot['name']}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      Text('${widget.snapshot['email']}',
                          style: TextStyle(fontSize: 16, letterSpacing: 2)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.27, left: size.width * 0.27),
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded),
                        Text("\t\t\tReturn"),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade200,
                        fixedSize: Size(150, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: 25,
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
                subtitle: Text('${widget.snapshot['regNo']}'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Contact Number'),
                subtitle: Text('${widget.snapshot['contact']}'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.add_road_rounded),
                title: Text('Route Name'),
                subtitle: Text('${widget.snapshot['address']}'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.airport_shuttle_rounded),
                title: Text('Route No.'),
                subtitle: Text('${widget.snapshot['routeNo']}'),
              ),
              Divider(),
              ListTile(
                  leading: Icon(Icons.money),
                  title: Text('Fee Clearance'),
                  subtitle: widget.snapshot['feeClearance'] == true
                      ? Text(
                          "Paid",
                          style: TextStyle(color: Colors.green),
                        )
                      : Text(
                          "Unpaid",
                          style: TextStyle(color: Colors.red),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
