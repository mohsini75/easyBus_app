import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  late BitmapDescriptor _pinMapIcon;
  BitmapDescriptor get PinMapIcon => _pinMapIcon;
  late Map<MarkerId, Marker> _markers;
  Map<MarkerId, Marker> get markers => _markers;
  final MarkerId markerId = MarkerId('1');

  late Location _location;
  Location get location => _location;

  late LatLng LocationPosition;
  LatLng get _Position => LocationPosition;

  bool LocationActive = true;

  LocationProvider() {
    _location = new Location();

    LocationPosition = LatLng(43.1203, 77.1025);
    _markers = {};
  }

  initalization() async {
    await getuserLocation();
    await setCustomMapPin();
  }

  getuserLocation() async {
    bool serviceEnabled;
    PermissionStatus _permission;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      _permission = await location.requestPermission();
      if (!serviceEnabled) {
        return;
      }
    }
    _permission = await location.hasPermission();
    if (_permission == PermissionStatus.denied) {
      _permission = await location.requestPermission();
      if (_permission != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      LocationPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      _markers = <MarkerId, Marker>{};
      Marker marker = Marker(
          markerId: markerId,
          position:
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
          icon: PinMapIcon,
          draggable: true,
          onDragEnd: (newPosition) {
            LocationPosition =
                LatLng(newPosition.latitude, newPosition.longitude);
          });
      _markers[markerId] = marker;
      notifyListeners();
    });
    print(_pinMapIcon);
    print(
        'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaobjectnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
    print(LocationPosition);
    notifyListeners();
  }

  setCustomMapPin() async {
    _pinMapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/google-maps-bus-icon-20.jpg');
  }
}
