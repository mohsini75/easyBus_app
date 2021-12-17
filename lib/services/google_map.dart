import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

class GoogleMapLocationScreen extends StatefulWidget {
  late LocationData currentLocation;
  //late LocationData destinationLocation;
  GoogleMapLocationScreen(this.currentLocation);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapLocationScreen> {
  Location location = Location();
  late StreamSubscription _locationSubscription;
  // late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    getLoc();
    enableLocationSubscription();
    // markers.add(Marker(
    //     markerId: MarkerId('current'),
    //     position: LatLng(widget.currentLocation.latitude!,
    //         widget.currentLocation.longitude!),
    //     icon: BitmapDescriptor.defaultMarker));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.currentLocation.latitude!,
                  widget.currentLocation.longitude!),
              zoom: 15),
          myLocationEnabled: true,
          //tiltGesturesEnabled: true,
          compassEnabled: true,
          //scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(markers.values)),
    ));
  }

  // void _onMapCreated(GoogleMapController controller) async {
  //   mapController = controller;
  // }

  void getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    widget.currentLocation = await location.getLocation();
    // _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) async {
      // print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        widget.currentLocation = currentLocation;
        //_initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
      });
    });
  }

  enableLocationSubscription() async {
    _locationSubscription =
        location.onLocationChanged.listen((LocationData result) async {
      if (mounted) {
        setState(() {
          widget.currentLocation = result;

          markers.clear();
          MarkerId markerId1 = MarkerId("origin");
          Marker marker1 = Marker(
            markerId: markerId1,
            position: LatLng(widget.currentLocation.latitude!,
                widget.currentLocation.longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          );

          markers[markerId1] = marker1;

          animateCamera(marker1);
        });
      }
    });
  }

  animateCamera(marker1) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(marker1));
  }
}
