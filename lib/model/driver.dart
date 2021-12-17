import 'package:location/location.dart';

class Driver {
  final String name;
  final int busNumber;
  final String vehicleNumber;
  List<String> routes;
  final int distanceCovered;
  final int Milage;
  List<String> studentRegistered;
  bool isEmergency;
  LocationData locationDriver;
  //  = LocationData.fromMap({
  //   "latitude": 33.651592,
  //   "longitude": 73.156456,
  // });

  Driver(
      {required this.name,
      required this.busNumber,
      required this.vehicleNumber,
      required this.routes,
      required this.distanceCovered,
      required this.Milage,
      required this.studentRegistered,
      required this.isEmergency,
      required this.locationDriver});
}
