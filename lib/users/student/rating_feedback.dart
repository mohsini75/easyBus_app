import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class RatingScreen extends StatefulWidget {
  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<RatingScreen> {
  CollectionReference store_rating_feedback =
      FirebaseFirestore.instance.collection('rating');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.cyan,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text(
              'Rate Us',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            onPressed: _showRatingAppDialog,
          ),
        ),
      ),
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
        starColor: Colors.amber,
        title: Text('Rate Us'),
        message: Text('Rate us for the better Ride and Reliabilty'),
        image: Image.asset(
          "assets/images/ratingBus.jpg",
          height: 160,
        ),
        submitButtonText: 'Submit',
        onCancelled: () => print('cancelled'),
        onSubmitted: (response) {
          store_rating_feedback
              .add({
                "rating": "${response.rating}",
                "comment": "${response.comment}"
              })
              .then((value) => print("rating Added"))
              .catchError((error) => print("Failed to add rating: $error"));
        });

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}
