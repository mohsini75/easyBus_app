import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/model/student.dart';
import 'package:demo/model/transaction.dart';
import 'package:demo/services/transaction_get_database.dart';
import 'package:demo/users/driver/Test/studentLocation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class MyTransactionChart extends StatefulWidget {
  @override
  _MyTransactionChartState createState() => _MyTransactionChartState();
}

class _MyTransactionChartState extends State<MyTransactionChart> {
  transactionDatabase database = transactionDatabase();
  StudentLocation student = StudentLocation();
  final User? user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;

  // Stream<QuerySnapshot<Map<String, dynamic>>> streamData() {
  //   return _firestore
  //       .collection("users")
  //       .where('id', isEqualTo: user!.uid)
  //       .snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> transaction =
        _firestore.collection('transactions').snapshots();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white12,
                width: 2,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            height: 50,
            width: 300,
            //children: [Text("Chart")],
            child: Container(
              height: 50,
            ), //Chart(_updatedMainTransaction),
          ),
          Container(
            margin: EdgeInsets.only(right: 60),
            child: Text(
              "Yours Transaction",
              style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    //color: Colors.purple.shade200,
                    blurRadius: 1,
                    offset: Offset(2, 2))
              ],
              //border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.only(left: 10),
            height: size.height * 0.8,
            width: size.width * 0.95,
            child: database.StreamCommon(transaction, "id"),
            // child: TransactionList(
            //   _userTransaction,
            //   DeleteTransaction,
            // ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Easy Bus Portal",
              style: TextStyle(letterSpacing: 2),
            ),
          )
        ],
      )),
    );
  }
}
