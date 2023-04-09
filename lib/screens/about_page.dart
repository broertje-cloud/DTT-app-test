import 'package:dtt/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sizer/sizer.dart';

// Dit is een Flutter-widget voor de About-pagina van de app, met informatie over het doel van de app en de ontwikkelaars ervan, evenals een link naar de website van de ontwikkelaars. Ook bevat het een bottom navigation bar die het mogelijk maakt om tussen de Home- en About-pagina's te navigeren.
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Welkom bij onze app! Deze app is ontwikkeld om jouw leven makkelijker te maken en je te voorzien van de informatie die je nodig hebt. We hebben ons best gedaan om de app intuïtief en gemakkelijk te gebruiken te maken, zodat je snel en efficiënt kunt vinden wat je zoekt. We hopen dat je onze app met plezier gebruikt en als je feedback hebt, horen we dat graag van je!',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Design and development',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  launch('https://www.d-tt.nl/');
                },
                child: Image.asset(
                  'images/load.png',
                  width: 100.0,
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  items: [
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
