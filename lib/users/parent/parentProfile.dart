import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(children: [
            Container(
              width: size.width,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue.shade200, Colors.purple.shade100],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter)),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    // child: Padding(
                    //   padding: EdgeInsets.only(top: 30, left: 1),
                    //   child: Icon(
                    //     Icons.arrow_back_ios_new,
                    //     size: 20,
                    //   ),
                    // ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    child: SvgPicture.asset(
                      "assets/icons/complain.svg",
                    ),
                  ),
                  Text(
                    'Student Name',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                  Text('University@email.com',
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
                    Text("\t\t\tBack to Home"),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade200,
                    fixedSize: Size(200, 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () {},
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
                  fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 2),
            ),
          ),
          ListTile(
            leading: Icon(Icons.perm_identity_rounded),
            title: Text('Name'),
            subtitle: Text('Umair Khan'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.app_registration_rounded),
            title: Text('Registration Number'),
            subtitle: Text('SP18-BSE-123'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.airport_shuttle_rounded),
            title: Text('Route No.'),
            subtitle: Text('12'),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            thickness: 4,
            height: 10,
          )
        ],
      ),
    );
  }
}
