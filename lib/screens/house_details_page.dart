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

//Deze code definieert de HouseDetailsPage-widget, die de details van een huis weergeeft, zoals de prijs, het aantal slaapkamers en badkamers, de locatie en een beschrijving van het huis. Het toont ook een willekeurige afbeelding van het huis uit een lijst van afbeeldingen en een kaart die de locatie van het huis toont.

// De HouseDetailsPage-widget heeft een MapSampleState-instantie die een methode myMethod() heeft, maar deze wordt niet gebruikt en kan dus worden verwijderd.

// De HouseDetailsPage-widget maakt gebruik van verschillende widgets zoals Scaffold, SingleChildScrollView, Column, Row, Image, Text, Icon, GoogleMap en BottomNavigationBar.

// De Scaffold-widget maakt de basisstructuur van de pagina, zoals de app-balk en het onderste navigatiegedeelte.

// De SingleChildScrollView-widget maakt het mogelijk om door de hele pagina te scrollen, zodat de inhoud niet buiten beeld raakt.

// De Column-widget maakt het mogelijk om de widgets onder elkaar te plaatsen.

// De Row-widget maakt het mogelijk om de widgets naast elkaar te plaatsen.

// De Image-widget toont een willekeurige afbeelding van het huis.

// De Text-widget toont verschillende tekstelementen, zoals de prijs, het aantal slaapkamers en badkamers, de locatie en de beschrijving van het huis.

// De Icon-widget toont verschillende iconen, zoals een bed, badkamer, lagen en locatie, die overeenkomen met de tekst die eronder wordt weergegeven.

// De GoogleMap-widget toont een kaart van de locatie van het huis met behulp van de GoogleMapsFlutter-bibliotheek.

// De BottomNavigationBar-widget maakt het mogelijk om tussen verschillende pagina's te navigeren, zoals de Home-pagina en de About-pagina. De onTap-functie is verantwoordelijk voor het navigeren naar de juiste pagina wanneer er op een item in de navigatiebalk wordt geklikt.
void main() {
  runApp(MyApp());
  MapSampleState mapSampleState = MapSampleState();
  mapSampleState.myMethod();
}

class HouseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> house;
  final List<String> houseImages = [    'images/classic-house-flower-garden-751996.jpg',    'images/istockphoto-1026205392-612x612.jpg',    'images/istockphoto-1211174464-612x612.jpg',  ];

  HouseDetailsPage({required this.house});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final String randomImage = houseImages[random.nextInt(houseImages.length)];

    return Scaffold(
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
                  target: LatLng(37.77483, -122.41942),
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

  void myMethod() {}
}
