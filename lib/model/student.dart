import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

import '/model/transaction.dart';

class Student {
  final String name;
  final String regNo;
  final String email;
  final String contactNo;
  final int routeNo;
  final int price;
  final DateTime date;
  final String address;
  final bool feeClearance;
  LocationData? currentLocation;
  LocationData? destinationLocation;
  //Image studentImage;
  //late List<Transaction> transactions;

  Student(
      {required this.name,
      required this.regNo,
      required this.email,
      required this.contactNo,
      required this.routeNo,
      required this.price,
      required this.date,
      required this.address,
      required this.feeClearance,
      this.currentLocation,
      this.destinationLocation});
  //required this.selectRoute,

  String get tmail => email;
  String get tnamae => name;
}
