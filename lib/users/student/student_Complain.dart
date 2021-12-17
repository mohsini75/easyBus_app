import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StudentComplainScreen extends StatefulWidget {
  const StudentComplainScreen({Key? key}) : super(key: key);

  @override
  _StudentComplainScreenState createState() => _StudentComplainScreenState();
}

class _StudentComplainScreenState extends State<StudentComplainScreen> {
  final _formKey = GlobalKey<FormState>();
  final reg_number = TextEditingController();
  final route_number = TextEditingController();
  final type_complain = TextEditingController();

  CollectionReference add_Student_Complain =
      FirebaseFirestore.instance.collection('studentComplains');

  Future<void> addStudentComplain() {
    print("add studentr wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    //print(textController.text);
    return add_Student_Complain
        .add({
          "regNo": reg_number.text,
          "comment": type_complain.text,
          "routeNo": route_number.text,
        })
        .then((value) => print("complain Added student"))
        .catchError((error) => print("Failed to add complain: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }

  contentBox(context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 60, right: 20, bottom: 20),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.purple.shade100,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Complain Box",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Student Registration No. ",
                      fillColor: Colors.blue,

                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: reg_number,
                    validator: (val) {
                      if (val!.length == 0 || val.isEmpty) {
                        return "Cannot be Empty";
                      } else if (!val.contains("-")) {
                        return "Must container dashes";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Route Number. ",
                      fillColor: Colors.blue,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    controller: route_number,
                    validator: (val) {
                      if (val!.length == 0 || val.isEmpty) {
                        return "Cannot be Empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Type Complain here ... ",
                      fillColor: Colors.blue,
                    ),
                    controller: type_complain,
                    validator: (val) {
                      if (val!.length == 0 || val.isEmpty) {
                        return "Cannot be Empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "< Cancel",
                              style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 3,
                                  color: Colors.red),
                            )),
                        FlatButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                addStudentComplain();
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              "Submit >",
                              style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 3,
                                  color: Colors.blue),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: SvgPicture.asset("assets/icons/complainStudent.svg")),
            ),
          ),
        ],
      ),
    );
  }
}
