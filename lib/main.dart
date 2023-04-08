import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dtt/screens/home_page.dart';
import 'package:dtt/screens/about_page.dart';
import 'package:dtt/screens/house_details_page.dart';
import 'package:dtt/widgets/loading_screen.dart';
//Dit is de implementatie van de MyApp widget in je Flutter applicatie. Deze widget bevat de MaterialApp widget, die de basis vormt van je applicatie en meerdere routes definieert die gebruikt kunnen worden om te navigeren naar verschillende pagina's in de app.

// De initialRoute parameter definieert de eerste pagina die wordt weergegeven wanneer de app wordt gestart, in dit geval de LoadingScreen pagina.

// De routes parameter is een map die de verschillende pagina's van de app definieert en de bijbehorende widgets die deze pagina's vertegenwoordigen. Elke route wordt geassocieerd met een unieke string, die later gebruikt kan worden om te navigeren naar de betreffende pagina met behulp van de Navigator widget.

// In dit geval definieert de routes map vier pagina's: LoadingScreen, HomePage, AboutPage en HouseDetailsPage. De HomePage, AboutPage en HouseDetailsPage routes bevatten de bijbehorende widgets die deze pagina's vertegenwoordigen, terwijl de LoadingScreen route wordt geassocieerd met de LoadingScreen widget. Wanneer je wilt navigeren naar een van deze pagina's, kun je de bijbehorende route-string gebruiken in combinatie met de Navigator widget.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Search',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.red,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/house-details': (context) => HouseDetailsPage(house: {}),
      },
    );
  }
}





