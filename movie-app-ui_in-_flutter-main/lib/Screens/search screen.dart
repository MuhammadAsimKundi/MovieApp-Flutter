import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'detial screen.dart';

class MovieSearchPage extends StatefulWidget {
  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}
class _MovieSearchPageState extends State<MovieSearchPage> {
  List<dynamic> _allMovies = [];
  List<dynamic> _filteredMovies = [];
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _jsonData1 = [];
  List<dynamic> _jsonData2 = [];
  @override
  void initState() {
    super.initState();
    fetchDataFromLocal();
    _searchController.addListener(_filterMovies);
  }
  @override
  void dispose() {
    _searchController.removeListener(_filterMovies);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchDataFromLocal() async {
    try {
      // Load the first JSON file from assets
      String jsonString1 = await rootBundle.loadString('assets/json1.json');
      _jsonData1 = json.decode(jsonString1);

      // Load the second JSON file from assets
      String jsonString2 = await rootBundle.loadString('assets/json2.json');
      _jsonData2 = json.decode(jsonString2);

      // Combine the data from both JSON files
      setState(() {
        _allMovies = [..._jsonData1, ..._jsonData2];
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }
  void _filterMovies() {
    final query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      setState(() {
        _filteredMovies = _allMovies.where((movie) {
          final name = movie['name'].toLowerCase();
          return name.contains(query);
        }).toList();
      });
    } else {
      setState(() {
        _filteredMovies = [];  // Clear the filtered movies list if the search query is empty
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_outlined),iconSize: 30,color: Colors.white,),
          Padding(
            padding: const EdgeInsets.only( right: 20, left: 20, bottom: 5),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMovies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          title: _filteredMovies[index]['name'],
                          year: _filteredMovies[index]['year'],
                          rating: _filteredMovies[index]['ratingValue'],
                          poster_url: _filteredMovies[index]['poster_url'],
                          summary_text:  _filteredMovies[index]['summary_text'],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(_filteredMovies[index]['poster_url']),
                    ),
                    title: Text(_filteredMovies[index]['name'], style: TextStyle(color: Colors.white)),
                    subtitle: Text('Director: ${_filteredMovies[index]['director']['name']}', style: TextStyle(color: Colors.white70)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
