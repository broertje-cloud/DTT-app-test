
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main.dart';
import 'package:dtt/screens/house_details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  void myMethod() {}
}


class MyWidget extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List _houses = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) async {
    setState(() {
      _isLoading = true;
      _searchQuery = query;
    });

    final url = Uri.parse('https://intern.d-tt.nl/api/house?q=$query');
    final headers = {'Access-Key': '98bww4ezuzfePCYFxJEWyszbUXc7dxRx'};
    final response = await http.get(url, headers: headers);

    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        _houses = jsonDecode(response.body);
      } else {
        _houses = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House Search'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search house here',
              ),
              onChanged: (query) {
                _performSearch(query);
              },
            ),
            SizedBox(height: 16.0),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : _houses.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/search_state_empty.png',
                            width: 200.0,
                            height: 200.0,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'No search results found. Please try another search.',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _houses.length,
                          itemBuilder: (context, index) {
                            final house = _houses[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HouseDetailsPage(
                                      house: house,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                            'images/search_state_empty.png',
                            width: 200.0,
                            height: 200.0,
                          ),
                          SizedBox(height: 16.0),
                                      Text(
                                        house['name'] ??
                                            ' name ',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        house['address'] ??
                                            ' address ',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}