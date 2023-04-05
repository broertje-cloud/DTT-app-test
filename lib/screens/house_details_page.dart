import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dtt/screens/about_page.dart';
import '../main.dart';

class HouseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> house;
  final List<String> houseImages = [    'images/classic-house-flower-garden-751996.jpg',    'images/istockphoto-1026205392-612x612.jpg',    'images/istockphoto-1211174464-612x612.jpg',  ];

  HouseDetailsPage({required this.house});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final String randomImage = houseImages[random.nextInt(houseImages.length)];

    return Scaffold(
      appBar: AppBar(
        title: Text('House Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                randomImage,
                width: double.infinity,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                house['address'] ?? 'No name available',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Price: \$${house['price']}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.king_bed),
                  SizedBox(width: 8.0),
                  Text(
                    'Rooms: ${house['rooms']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Bathrooms: ${house['bathrooms']}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Description: ${house['description']}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Agent: ${house['agent']}',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void myMethod() {}
}
