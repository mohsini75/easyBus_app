import 'package:demo/model/driver.dart';
import 'package:location/location.dart';

class DriverLocation {
  late Driver driver;
  DriverLocation() {
    driver = Driver(
        Milage: 12,
        name: "mohsin",
        busNumber: 12,
        distanceCovered: 123,
        vehicleNumber: "",
        routes: [],
        studentRegistered: [],
        isEmergency: false,
        locationDriver: currentLocation);
  }
  var currentLocation = LocationData.fromMap({
    "latitude": 33.651592,
    "longitude": 73.156456,
  });

  LocationData getLoc() {
    return currentLocation;
  }
}
