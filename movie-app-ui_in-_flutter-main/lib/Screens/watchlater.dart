import 'package:flutter/material.dart';
import 'package:movieapp/Screens/watchlater%20controler.dart';
import 'package:provider/provider.dart';
class WatchLaterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<WatchLaterProvider>(
        builder: (context, watchLaterProvider, child) {
          return ListView.builder(
            itemCount: watchLaterProvider.watchLater.length,
            itemBuilder: (context, index) {
              final movie = watchLaterProvider.watchLater[index];
              return Dismissible(
                key: Key(movie['name'].toString()), // Ensure each item has a unique key
                onDismissed: (direction) {
                  // Remove the item from the provider
                  watchLaterProvider.removeMovie(movie['name']);
                  // Show a snackbar or other feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${movie['name']} removed from watch later list"),
                    ),
                  );
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(movie['poster_url']),
                    onBackgroundImageError: (_, __) => Icon(Icons.error, color: Colors.white),
                  ),
                  title: Text(movie['name'], style: const TextStyle(color: Colors.white)),
                  subtitle: Text(movie['year'], style: const TextStyle(color: Colors.white)),
                  // Add more widgets as needed to display other properties of the item
                ),
              );
            },
          );
        },
      ),
    );
  }
}
