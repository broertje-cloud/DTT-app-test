import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dtt/screens/home_page.dart';
import 'package:dtt/screens/about_page.dart';
import 'package:dtt/screens/house_details_page.dart';
import 'package:dtt/widgets/loading_screen.dart';


void main() {
  runApp(MyApp());
  HomePage homePage = HomePage();
  homePage.myMethod();
  runApp(MyApp());
  AboutPage aboutPage = AboutPage();
  aboutPage.myMethod();
  runApp(MyApp());
    Map<String, dynamic> house = {
  
};
  HouseDetailsPage houseDetailsPage = HouseDetailsPage(house: house);
  houseDetailsPage.myMethod();
  runApp(MyApp());
  LoadingScreen loadingScreen = LoadingScreen();
  loadingScreen.myMethod();
  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}

