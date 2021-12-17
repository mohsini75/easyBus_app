import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class MaintenanceReportScreen extends StatefulWidget {
  const MaintenanceReportScreen({Key? key}) : super(key: key);

  @override
  _MaintenanceReportScreenState createState() =>
      _MaintenanceReportScreenState();
}

class _MaintenanceReportScreenState extends State<MaintenanceReportScreen> {
  final fuel = TextEditingController();
  final distance = TextEditingController();
  ImagePicker picker = ImagePicker();
  final User? user = FirebaseAuth.instance.currentUser;

  CollectionReference add_report =
      FirebaseFirestore.instance.collection('Maintenance Report');

  Future<void> addReport() {
    print("add studentr wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    //print(textController.text);
    return add_report
        .add({
          // "id": user!.uid,
          "distance": distance.text,
          "fuel comsumption": fuel.text,
        })
        .then((value) => print("Added report"))
        .catchError((error) => print("Failed : $error"));
  }

  int activeStep = 0; // Initial step set to 5.

  int upperBound = 2;
  // upperBound MUST BE total number of icons minus 1.

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
      keyboardType: TextInputType.number,
    );
  }

  Widget screenReturn(int index) {
    if (index == 0) {
      return Stack(children: [
        CircleAvatar(
          radius: 70,
          child: ClipOval(
            child: Image.asset(
              'assets/images/Smartphone 03.jpg',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            height: 40,
            width: 40,
            child: Positioned(
              right: 1,
              bottom: 1,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          onTap: () {
            _getFromCamera();
          },
        )
      ]);
    } else if (index == 1) {
      return textFieldData('Enter fuel consumption', index, fuel);
    } else {
      return textFieldData('Enter Distance Covered', index, distance);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        picker = File(pickedFile.path) as ImagePicker;
      });
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
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Maintenance Report',
            style: TextStyle(color: Colors.blue, letterSpacing: 3),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconStepper(
                icons: [
                  Icon(Icons.photo_size_select_actual_outlined),
                  Icon(Icons.meeting_room_outlined),
                  Icon(Icons.social_distance_outlined),
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
        return 'Insert Milage';

      case 2:
        return 'Total Distance Covered';

      default:
        return 'Upload Meter Pic';
    }
  }
}
