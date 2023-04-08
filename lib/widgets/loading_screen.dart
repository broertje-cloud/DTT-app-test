import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main.dart';
import 'package:dtt/screens/home_page.dart';

// Deze code creëert een StatefulWidget genaamd LoadingScreen. Dit wordt gebruikt om een laadscherm te maken voordat de hoofdpagina (HomePage) van de app wordt geladen.

// De _LoadingScreenState is de state-klasse van de LoadingScreen. Het bevat een boolean genaamd _isLoading, die true is zolang er gegevens worden opgehaald en het laadscherm moet worden weergegeven. De _fetchData() methode maakt gebruik van de Future.delayed() methode om 3 seconden te wachten voordat de _isLoading boolean op false wordt gezet. Dit zorgt ervoor dat het laadscherm na 3 seconden verdwijnt.

// De initState() methode is een lifecycle-methode die wordt aangeroepen wanneer de State is geïnitialiseerd. Hier roepen we de _fetchData() methode aan.

// In de build() methode wordt er gecontroleerd of _isLoading true is en wordt het laadscherm _buildLoading() weergegeven totdat het ophalen van de gegevens is voltooid en _isLoading op false wordt gezet. Wanneer _isLoading op false staat, wordt de HomePage weergegeven.

// De _buildLoading() methode geeft een Scaffold terug met een rode achtergrond en een Image.asset() widget met een afbeelding om het laadscherm weer te geven.

// De MaterialApp widget is de hoofdwidget van de app. Hierin is de app-titel en het thema gedefinieerd. De home parameter verwijst naar de _buildContent() methode. Hier wordt bepaald of het laadscherm of de HomePage moet worden weergegeven.

// Tot slot is er een myMethod() methode gedefinieerd in de LoadingScreen widget, die momenteel niet wordt gebruikt.
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();

  void myMethod() {}
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Search',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return _buildLoading();
    } else {
      return HomePage();
    }
  }

  Widget _buildLoading() {
  return Scaffold(
    backgroundColor: Colors.red, // toegevoegd
    body: Center(
      child: Image.asset(
        'images/DTTLoading.png',
        width: 200.0,
        height: 200.0,
      ),
    ),
  );
}


  Future<void> _fetchData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _isLoading = false;
    });
  }
}