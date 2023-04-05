import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About this app',
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
                'About DTT in Amsterdam',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'DTT is een softwarebedrijf dat in 2010 is opgericht in Amsterdam, Nederland. Het bedrijf richt zich op de ontwikkeling van mobiele apps, webapplicaties, games en andere digitale producten voor klanten wereldwijd. Ze hebben meer dan 100 succesvolle projecten op hun naam staan en werken voor klanten zoals KPMG, ING, Rijksoverheid, FOX Sports en Philips DTT is bekend om hun expertise in de ontwikkeling van apps voor zowel iOS als Android, en hebben veel prijzen gewonnen voor hun werk. Het bedrijf heeft een team van meer dan 70 professionals die zich richten op design, ontwikkeling, projectmanagement, kwaliteitsbewaking en marketing. DTT is ook een erkend leerbedrijf en biedt stageplaatsen en afstudeeropdrachten aan studenten die geïnteresseerd zijn in softwareontwikkeling. Het bedrijf heeft zijn hoofdkantoor in Amsterdam en heeft ook een kantoor in India. Ze werken met klanten over de hele wereld en hebben een diverse en internationale werkomgeving.',
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
              Image.asset(
                'images/load.png', 
                width: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void myMethod() {}
}
