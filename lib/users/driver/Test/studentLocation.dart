import 'package:demo/model/driver.dart';
import 'package:demo/model/student.dart';
import 'package:demo/users/driver/Test/driverLocation.dart';
import 'package:location/location.dart';

class StudentLocation {
  DriverLocation _driver = DriverLocation();
  //late Driver d;
  late Student student;
  StudentLocation() {
    student = Student(
        name: "Mohsin",
        regNo: "SP18-BSE-123",
        email: "moh@cui.com",
        contactNo: "0312321568",
        routeNo: 2,
        date: DateTime.now(),
        price: 150,
        address: "umer market",
        feeClearance: false,
        currentLocation: currentLocation,
        destinationLocation: _driver.currentLocation);
  }
  var currentLocation = LocationData.fromMap({
    "latitude": 33.651592,
    "longitude": 73.156456,
  });
}
