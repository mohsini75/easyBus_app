import 'package:flutter/material.dart';

class VehicleHealth extends StatefulWidget {
  const VehicleHealth({Key? key}) : super(key: key);

  @override
  _VehicleHealthState createState() => _VehicleHealthState();
}

class _VehicleHealthState extends State<VehicleHealth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                      child: Text(
                        'Vehicle Route',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 23),
                      )),
                  SizedBox(height: 40),
                  Container(
                    width: 400,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Column(
                      children: [
                        Text(
                          "Vehicle Health",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(children: [
                          Text(
                            "Name Vehicle",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "Route",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "Vehicle",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            "Distance",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),

                        ],),
                        Text("Chart",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),),
                        Container(width: 100,height: 70,
                          child: Image.asset('assets/image.jpg'),)
                      ],
                    ),
                  )
                ]))));
  }
}

class VehicleRoute extends StatefulWidget {
  const VehicleRoute({Key? key}) : super(key: key);

  @override
  _VehicleRouteState createState() => _VehicleRouteState();
}

class _VehicleRouteState extends State<VehicleRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:Container());
  }
}
