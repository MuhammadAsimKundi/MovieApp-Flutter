import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class WatchLaterProvider with ChangeNotifier {
  List<dynamic> watchLater = [];
  List<dynamic> _jsonData1 = [];
  List<dynamic> _jsonData2 = [];

  WatchLaterProvider() {
    loadWatchLater();
  }
  void addToWatchLater(dynamic movie) {
    if (!watchLater.contains(movie)) {
      watchLater.add(movie);
      saveWatchLater();
      notifyListeners();
    }
  }
  void saveWatchLater() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(watchLater);
    await prefs.setString('watchLater', encodedData);
  }

  void removeMovie(String name) {
    watchLater.removeWhere((movie) => movie['name'] == name);
    saveWatchLater(); // Save the updated list
    notifyListeners();
  }

  void loadWatchLater() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString('watchLater');
    if (encodedData != null) {
      watchLater = json.decode(encodedData);
      notifyListeners();
    }
  }

  Future<void> fetchDataFromLocal() async {
    try {
      // Load the first JSON file from assets
      String jsonString1 = await rootBundle.loadString('assets/json1.json');
      final List<dynamic> data1 = json.decode(jsonString1);

      // Load the second JSON file from assets
      String jsonString2 = await rootBundle.loadString('assets/json2.json');
      final List<dynamic> data2 = json.decode(jsonString2);

      // Update state with the loaded data
      _jsonData1 = data1;
      _jsonData2 = data2;

      notifyListeners(); // Notify listeners if necessary
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  List<dynamic> get jsonData1 => _jsonData1;
  List<dynamic> get jsonData2 => _jsonData2;
}
