// Dit is de import sectie waarin de benodigde packages worden geïmporteerd
// dart:math wordt geïmporteerd om een willekeurige afbeelding voor het huis te kiezen
// flutter, http, google_maps_flutter en sizer worden geïmporteerd om het huisgegevens te tonen en de kaart te maken
import 'dart:math';
import 'package:dtt/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dtt/screens/about_page.dart';
import '../main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dtt/models/house_model.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(MyApp());
  MapSampleState mapSampleState = MapSampleState();
  mapSampleState.myMethod();
}
// Dit is de widget voor de huisdetailspagina die wordt gebruikt om informatie over het huis te tonen
class HouseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> house;
  final List<String> houseImages = [    'images/classic-house-flower-garden-751996.jpg',    'images/istockphoto-1026205392-612x612.jpg',    'images/istockphoto-1211174464-612x612.jpg',  ];

  HouseDetailsPage({required this.house});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final String randomImage = houseImages[random.nextInt(houseImages.length)];

    return Scaffold(
      // Hier wordt de layout van de huisdetailspagina opgebouwd met informatie over het huis en een kaart van de locatie
  body: SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            randomImage,
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Price: \$${house['price']}',
            style: const TextStyle(fontSize: 18.0),
          ),
          Row(
  children: [
    const Icon(Icons.king_bed),
    const SizedBox(width: 2.0),
    Text(
      ': ${house['bedrooms']}',
      style: const TextStyle(fontSize: 18.0),
    ),
    const SizedBox(width: 16.0),
    const Icon(Icons.bathroom),
    const SizedBox(width: 2.0),
    Text(
      ': ${house['bathrooms']}',
      style: const TextStyle(fontSize: 18.0),
    ),
    const SizedBox(width: 16.0),
    const Icon(Icons.layers),
    const SizedBox(width: 2.0),
    Text(
      ': ${house['layers']}',
      style: const TextStyle(fontSize: 18.0),
    ),
    const SizedBox(width: 16.0),
    const Icon(Icons.place),
    const SizedBox(width: 2.0),
    Text(
      ': ${house['place']}',
      style: const TextStyle(fontSize: 18.0),
    ),
  ],
),

          const SizedBox(height: 8.0),
          Text(
            'Description: ${house['description']}',
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Agent: ${house['agent']}',
            style: const TextStyle(fontSize: 18.0),
          ),
          
          const SizedBox(
              height: 100,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(52.379189, 4.899431),
                  zoom: 12,
                ),
              ),
            ),
        ],
      ),
    ),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.info),
        label: 'About',
      ),
    ],
    
    onTap: (index) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutPage()),
        );
      }
      
    },
  ),
  
);

  }

  void myMethod() {
    
  }
}
