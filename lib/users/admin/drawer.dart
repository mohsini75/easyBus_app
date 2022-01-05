import 'package:demo/users/student/view_users_screen.dart';
import 'package:demo/users/student/view_user_card.dart';

import '/users/student/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                image: new DecorationImage(
                    image: AssetImage('assets/images/busDashboard.png'),
                    fit: BoxFit.fill)),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello, Admin',
                    style: TextStyle(
                        letterSpacing: 2, color: Colors.white, fontSize: 18),
                  ),
                  CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage('assets/images/Smartphone 03.jpg')),
                ],
              ),
              SizedBox(height: 40),
              Text(
                'Lets get Started ',
                style: TextStyle(letterSpacing: 2, color: Colors.white),
              ),
            ]),
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: (Text('View Profile')),
              onTap: () {}),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_road_rounded),
            onTap: () {},
            title: (Text('Manage Routes')),

            //Navigator.of(context).pushReplacementNamed(OrderScreen.route),
          ),
          // Divider(),
          // ListTile(
          //   leading: Icon(
          //     Icons.people,
          //   ),
          //   onTap: () {},
          //   title: (Text('Dashboard')),

          //   //   Navigator.of(context).pushReplacementNamed(UserProductScreen.route),
          // ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.location_history,
            ),
            onTap: () {},
            title: (Text('View Location')),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.people,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return ViewUserScreen("student");
              }));
            },
            title: (Text('View Students')),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
            ),
            onTap: () {
              _auth.signOut();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            title: (Text('Log Out')),
          )
        ],
      ),
    );
  }
}
