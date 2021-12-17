import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverComplainScreen extends StatefulWidget {
  const DriverComplainScreen({Key? key}) : super(key: key);

  @override
  _DriverComplainScreenState createState() => _DriverComplainScreenState();
}

class _DriverComplainScreenState extends State<DriverComplainScreen> {
  final reg_number = TextEditingController();
  var behavoir = "Behavior Issue";
  var fee = "Fee Issue";
  var other = "Others";
  final GlobalKey<FormState> _formKey = GlobalKey();
  CollectionReference add_Student_Complain =
      FirebaseFirestore.instance.collection('driverComplains');

  Future<void> addDriverComplain() {
    print("add studentr wali sideea gai haaa");
    // Call the user's CollectionReference to add a new user
    //print(textController.text);
    return add_Student_Complain
        .add({
          "regNo": reg_number.text,
          "comment": "behavoir",
        })
        .then((value) => print("complain Added driver"))
        .catchError((error) => print("Failed to add complain: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
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
                Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Student Registration No. ",
                      fillColor: Colors.black,
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
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.streetAddress,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                ElevatedButton(
                  child: Text(behavoir),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade300,
                      fixedSize: Size(150, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  child: Text(fee),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade300,
                      fixedSize: Size(100, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  child: Text(other),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade300,
                      fixedSize: Size(100, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 12,
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
                              addDriverComplain();
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
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: SvgPicture.asset("assets/icons/complain.svg")),
            ),
          ),
        ],
      ),
    );
  }
}
