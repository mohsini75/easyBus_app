import 'package:flutter/material.dart';
import 'dart:io' show Platform; 
import 'VehicleHealth.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Center(
                    child: Text(
                  'Admin DashBoard',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                )),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Employee Dashboard',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VehicleRoute()));
                              },
                              child: Text(
                                "Vehicle Route",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(
                            width: 50,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VehicleHealth()));
                              },
                              child: Text(
                                "Vehicle Health",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Total Students',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 120,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 400,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Total Employees',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 120,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black)),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  width: 400,
                  height: 300,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Assign Driver",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Name"),
                                Container(
                                  width: 100,
                                  child: TextField(
                                    controller: controller1,
                                    decoration:
                                        InputDecoration(helperText: 'Name'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Column(
                              children: [
                                Text("Route"),
                                Container(
                                  width: 100,
                                  child: TextField(
                                    controller: controller2,
                                    decoration:
                                        InputDecoration(helperText: 'Route'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            //uploadFile();
                          },
                          child: Text("Assign"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // uploadFile() async {
  //   await FirebaseFirestore.instance.collection("Assign").doc().set({
  //     'name': controller1.text,
  //     'routes': controller2.text,

  //   });
  // }

}
