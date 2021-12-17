import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  LocationData currentLocation;
  LocationData destinationLocation;

  MapScreen({required this.currentLocation, required this.destinationLocation});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Completer _controller = Completer();
  late StreamSubscription _locationSubscription;
  Location location = Location();
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  // double _originLatitude = 26.48424, _originLongitude = 50.04551;
  // double _destLatitude = 26.46423, _destLongitude = 50.06358;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  Location _locationService = new Location();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyAki9aOH7NXRDbOxWJ5d8-IpbpMM5e5ISA";

  @override
  void initState() {
    super.initState();
    getLoc();

    /// origin marker
    _addMarker(
        LatLng(widget.currentLocation.latitude!,
            widget.currentLocation.longitude!),
        "origin",
        BitmapDescriptor.defaultMarkerWithHue(60));

    /// destination marker
    _addMarker(
        LatLng(widget.destinationLocation.latitude!,
            widget.destinationLocation.longitude!),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(60));

    //get location and track the location with pin
    enableLocationSubscription();

    //polylines
    //_getPolyline();
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
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
      )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    mapController = controller;
    _getPolyline();
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  void getLoc() async {
    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    widget.currentLocation = await location.getLocation();
    // _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   // print("${currentLocation.longitude} : ${currentLocation.longitude}");
    //   setState(() {
    //     widget.currentLocation = currentLocation;
    //     //_initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    //   });
    //  });
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.purple.shade200,
        width: 7,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  enableLocationSubscription() async {
    _locationSubscription =
        _locationService.onLocationChanged.listen((LocationData result) async {
      if (mounted) {
        setState(() {
          widget.currentLocation = result;

          markers.clear();
          MarkerId markerId1 = MarkerId("origin");
          Marker marker1 = Marker(
            markerId: markerId1,
            position: LatLng(widget.currentLocation.latitude!,
                widget.currentLocation.longitude!),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          );
          MarkerId markerId2 = MarkerId("destination");
          Marker marker2 = Marker(
            markerId: markerId2,
            position: LatLng(widget.destinationLocation.latitude!,
                widget.destinationLocation.longitude!),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet),
          );
          markers[markerId1] = marker1;
          markers[markerId2] = marker2;
          animateCamera(marker1);
        });
      }
    });
    //_getPolyline();
  }

  animateCamera(marker1) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(marker1));
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(
          widget.currentLocation.latitude!, widget.currentLocation.longitude!),
      PointLatLng(widget.destinationLocation.latitude!,
          widget.destinationLocation.longitude!),
      travelMode: TravelMode.driving,
      //wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
