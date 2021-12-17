import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/users/student/bottom_tab_screen.dart';
import 'package:demo/users/student/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
User? loggedInUser = _auth.currentUser;

class RegistrationForm extends StatelessWidget {
  static const routeName = "/reg-form";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String id = loggedInUser!.uid;
    late String name;
    late String regNo;
    late String contactNo;
    late String routeNo;
    late String address;

    void showDailog(String meassage) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error Message'),
          content: Text(meassage),
          actions: [
            TextButton(
              child: Text("okay"),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
      );
    }
    //late String _mobile;

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Form"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                    onChanged: (val) {
                      name = val;
                    },
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name required!';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    onChanged: (val) {
                      regNo = val;
                    },
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.school),
                      hintText: 'Enter your Regestration Number',
                      labelText: 'Regestration Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Reg no. required!';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    hintText: 'Enter a phone number',
                    labelText: 'Phone',
                  ),
                  onChanged: (val) {
                    contactNo = val;
                  },
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value != null) {
                      return 'contact required!';
                    } else if ((value)!.length != 11)
                      return 'Mobile Number must be of 11 digit';
                    else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                    onChanged: (val) {
                      routeNo = val;
                    },
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.bus_alert),
                      hintText: 'Enter your route number',
                      labelText: 'Route',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'route required!';
                      } else {
                        return null;
                      }
                    }),
                TextFormField(
                    onChanged: (val) {
                      address = val;
                    },
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.home),
                      hintText: 'Enter your address',
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'address required!';
                      } else {
                        return null;
                      }
                    }),
                Container(
                  padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                  child: new ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                      print(id);
                      _firestore.collection('students').add({
                        'id': id,
                        'name': name,
                        'regNo': regNo,
                        'contactNo': contactNo,
                        'routeNo': routeNo,
                        'address': address,
                      });
                      print("Student added!");
                      // if (_formKey.currentState?.validate() == true) {
                      //   // If the form is valid, display a Snackbar.
                      //   Scaffold.of(context).showSnackBar(
                      //       SnackBar(content: Text('Data is in processing.')));
                      // }
                      _formKey.currentState?.reset();
                      Navigator.pushReplacementNamed(
                          context, StudentBottomTabScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
