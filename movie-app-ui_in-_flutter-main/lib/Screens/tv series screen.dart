import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'detial screen.dart';

class Tvseries extends StatefulWidget {
  const Tvseries({super.key});
  @override
  State<Tvseries> createState() => _TvseriesState();
}
class _TvseriesState extends State<Tvseries> {
  List<dynamic> _jsonData = [];
  String url = "";
  int index1 = 0;
  String title = "";
  String genre = "";
  String year = "";
  String rating = "";
  String poster_url = "";
  @override
  void initState() {
    super.initState();
    fetchDataFromLocal();
  }
  Future<void> fetchDataFromLocal() async {
    try {
      // Load the JSON file from assets
      String jsonString = await rootBundle.loadString('assets/tvseries.json');

      // Parse the JSON string
      final dynamic data = json.decode(jsonString);
      setState(() {
        _jsonData = data;
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of items per row
          crossAxisSpacing: 6, // Horizontal spacing between items
          mainAxisSpacing: 4.0, // Vertical spacing between items
        ),
        itemCount: _jsonData.length,
        itemBuilder: (context, index) {
          return _buildListItem(context, index);
        },
      ),
    );
  }
  Widget _buildListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              title: _jsonData[index]['name'],
              year: _jsonData[index]['year'],
              rating: _jsonData[index]['ratingValue'],
              poster_url: _jsonData[index]['poster_url'],
              summary_text:  _jsonData[index]['summary_text'],


            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[900],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  _jsonData[index]['poster_url'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}