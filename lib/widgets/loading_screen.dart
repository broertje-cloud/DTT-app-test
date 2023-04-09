import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main.dart';
import 'package:dtt/screens/home_page.dart';

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