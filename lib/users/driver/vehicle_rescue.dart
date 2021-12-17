import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class vehicleRescueScreen extends StatefulWidget {
  const vehicleRescueScreen({Key? key}) : super(key: key);

  @override
  _vehicleRescueScreenState createState() => _vehicleRescueScreenState();
}

class _vehicleRescueScreenState extends State<vehicleRescueScreen> {
  final report = TextEditingController();
  bool r = false;
  String rescue = "received";

  CollectionReference add_report =
      FirebaseFirestore.instance.collection('vehicle rescue');
  final User? user = FirebaseAuth.instance.currentUser;

  // Stream<QuerySnapshot<Map<String, dynamic>>> streamData() {
  //   return _firestore = FirebaseFirestore.instance
  //       .collection("users")
  //       .where('id', isEqualTo: user!.uid)
  //       .snapshots();
  // }

  Future<void> addReport() {
    print("add studentr wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    //print(textController.text);
    return add_report
        .add({
          // "id": user!.uid,
          "report": report.text,
          "rescue reached": rescue,
        })
        .then((value) => print("Added report"))
        .catchError((error) => print("Failed : $error"));
  }

  int activeStep = 0; // Initial step set to 5.

  int upperBound = 2;
  // upperBound MUST BE total number of icons minus 1.
  _callNumber() async {
    const number = '+923400540023'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  Widget textFieldData(
      String labelText, int index, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: new InputDecoration(
        labelText: labelText,
        fillColor: Colors.black,

        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        //fillColor: Colors.green
      ),
      validator: (val) {
        if (val!.length == 0 || val.isEmpty) {
          return "Cannot be Empty";
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.text,
    );
  }

  Widget screenReturn(int index) {
    if (index == 1) {
      return Center(
        child: RaisedButton(
          onPressed: _callNumber,
          child: Text('Call Admin'),
        ),
      );
    } else if (index == 0) {
      return textFieldData('Report bus issue', index, report);
    } else {
      return ElevatedButton(
          onPressed: () {
            setState(() {
              if (r = true) {
                rescue = "received";
              } else {
                rescue = "not received";
              }

              print(rescue);
            });
          },
          child: Text("tap on received"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                addReport();
              },
              icon: Icon(
                Icons.save_rounded,
                color: Colors.blue,
              ),
            )
          ],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.blue,
            ),
            onPressed: () {
              //addReport();
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Vehicle Rescue',
            style: TextStyle(color: Colors.blue, letterSpacing: 3),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconStepper(
                icons: const [
                  Icon(Icons.report_sharp),
                  Icon(Icons.call),
                  Icon(Icons.recent_actors)
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
              header(),
              Expanded(
                child: Container(
                    height: 50, child: Center(child: screenReturn(activeStep))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  previousButton(),
                  nextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return FlatButton(
      onPressed: () {
        // Increment activeStep, when the next button is tapped. However, check for upper bound.
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        }
      },
      child: Row(
        children: [
          Text(
            'Continue',
            style: TextStyle(color: Colors.green, letterSpacing: 2),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return FlatButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: Row(
        children: [
          Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: Colors.red,
          ),
          Text(
            'Return',
            style: TextStyle(color: Colors.red, letterSpacing: 2),
          ),
        ],
      ),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      width: 300,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Contact Admin';

      case 2:
        return 'Rescued???';

      default:
        return 'Report problem';
    }
  }
}
