import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/web_app/view_users_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ManageDrivers extends StatelessWidget {
  const ManageDrivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Drivers"),
      ),
      body: SafeArea(
        child: ViewDriverScreen("driver"),
      ),
    );
  }
}
