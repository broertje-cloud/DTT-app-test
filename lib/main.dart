import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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
        title: const Text('House Search'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search house here',
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
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                            'images/search_state_empty.png',
                            width: 200.0,
                            height: 200.0,
                          ),
                          const SizedBox(height: 16.0),
                                      Text(
                                        house['name'] ??
                                            ' name ',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        house['address'] ??
                                            ' address ',
                                        style: const TextStyle(
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

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About this app',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Some information about the app...',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}



// om details van hizen te zien


class HouseDetailsPage extends StatelessWidget {
  final Map<String, dynamic> house;

  HouseDetailsPage({required this.house});

  @override
  Widget build(BuildContext context) {
    final LatLng houseLocation = LatLng(house['latitude'], house['longitude']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('House Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: houseLocation,
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(house['address']),
                  position: houseLocation,
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house['address'] ?? 'No name available',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Price: ${house['price']}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Rooms: ${house['rooms']}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Bathrooms: ${house['bathrooms']}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Description: ${house['description']}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Agent: ${house['agent']}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//loading screen Hier roepen we _buildContent() aan in de home eigenschap van de MaterialApp. _buildContent() bepaalt welke widget er moet worden weergegeven op basis van de _isLoading variabele. De _buildLoading() methode geeft de laadindicator weer en de _buildHome() methode geeft de homepagina weer
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
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
        primarySwatch: Colors.blue,
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
      body: Center(
        child: Image.asset(
          'images/load.png',
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isLoading = false;
    });
  }
}





