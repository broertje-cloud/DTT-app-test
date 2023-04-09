
import 'package:dtt/screens/about_page.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../main.dart';
import 'package:dtt/screens/house_details_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

// Deze code haalt gegevens op van een API en toont een lijst met huizen op basis van de zoekopdracht van de gebruiker
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

  if (query.isEmpty) {
    setState(() {
      _houses = [];
      _isLoading = false;
      _searchQuery = '';
    });
  } else {
    final url = Uri.parse('https://intern.d-tt.nl/api/house?q=$query');
    final headers = {'Access-Key': '98bww4ezuzfePCYFxJEWyszbUXc7dxRx'};
    final response = await http.get(url, headers: headers);

    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        _houses = jsonDecode(response.body);
        if (_houses.isEmpty) {
          // Geen resultaten gevonden, toon een foutmelding
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Geen resultaten gevonden'),
                content: const Text('Er zijn geen resultaten gevonden voor uw zoekopdracht.'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        _houses = [];
      }
    });
  }
}

 String _getFormattedPrice(dynamic price) {
    return '\€ ${price.toStringAsFixed(2)}'; // prijs opmaken als valuta
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'bathroom':
        return Icons.bathtub;
      case 'bedroom':
        return Icons.bed;
      case 'parking':
        return Icons.local_parking;
      default:
        return Icons.help_outline;
    }
  }

List<dynamic> _sortHousesByPrice(List<dynamic> houses) {
  houses.sort((a, b) => a['price'].compareTo(b['price']));
  return houses;
}


@override
Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.white,
    title: const Text(
      'DTT real estate',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    centerTitle: false,
  ),
  
    body: Container(     
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelText: 'Search house here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  _performSearch(query);
                },
              ),
              
          const SizedBox(height: 16.0),
          _isLoading
              ? const Center(
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
              const SizedBox(height: 16.0),
              const Text(
                'No search results found. Please try another search.',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
          
               : Expanded(
                        child: ListView.separated(
                          itemCount: _houses.length,
                          itemBuilder: (context, index) {
                            final house = _houses[index];
                            final name = 'huis ${house['id']}'; // genereer de naam op basis van het ID
                            final price = _getFormattedPrice(house['price']);
                            _houses = _sortHousesByPrice(_houses);
                            final bathroomCount = house['bathrooms'] ?? 0;
                            final bedroomCount = house['bedrooms'] ?? 0;
                            final layers = house['layers'] ?? 0;
                            final place = house['place'] ?? 0;
                            final parkingCount = house['parking'] ?? 0;
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
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                'images/istockphoto-1026205392-612x612.jpg',
                                width: 100.0,
                                height: 100.0,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      price, // gebruik de gegenereerde naam
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      house['address'] ?? ' ',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'images/ic_bath.svg',
                                          width: 24.0,
                                          height: 24.0,
                                        ),
                                        SvgPicture.asset(
                                          'images/ic_bed.svg',
                                          width: 24.0,
                                          height: 24.0,
                                        ),
                                        SvgPicture.asset(
                                          'images/ic_layers.svg',
                                          width: 24.0,
                                          height: 24.0,
                                        ),
                                        SvgPicture.asset(
                                          'images/ic_location.svg',
                                          width: 24.0,
                                          height: 24.0,
                                        ),
                                      const SizedBox(width: 8.0),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                  ),
                );
              },
              
              separatorBuilder: (context, index) {
                return index % 20 == 19
                    ? const Divider()
                    : const SizedBox.shrink();
              },
            ),
          ),          
        ],
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

}