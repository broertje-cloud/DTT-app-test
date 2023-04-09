import 'dart:async';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main.dart';

class MapSample extends StatefulWidget {
  final String cityName;

  const MapSample({Key? key, required this.cityName}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kAmsterdam = CameraPosition(
    target: LatLng(52.379189, 4.899431),
    zoom: 12,
  );


  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(52.379189, 4.899431),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Marker> _markers = Set();
  
  get cityName => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kAmsterdam,

        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
          await _addMarkers();
          setState(() {});
        },
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

 Future<void> _addMarkers() async {
  final url = Uri.parse('https://intern.d-tt.nl/api/house?q=$cityName');
  final headers = {'Access-Key': '98bww4ezuzfePCYFxJEWyszbUXc7dxRx'};
  final response = await http.get(url, headers: headers);
  final List<dynamic> houses = json.decode(response.body)['data'];

  houses.forEach((house) {
    final marker = Marker(
      markerId: MarkerId(house['id']),
      position: LatLng(house['latitude'], house['longitude']),
      infoWindow: InfoWindow(title: house['address']),
    );
    _markers.add(marker);
  });
}

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void myMethod() {}
}
