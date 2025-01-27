import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/Screens/search%20screen.dart';
import 'package:movieapp/Screens/tv%20series%20screen.dart';
import 'package:movieapp/Screens/watchlater.dart';
import 'Homepage.dart';
import 'moreoption.dart';
import 'movies.dart';
class appbar_and_navigationbar extends StatefulWidget {
  const appbar_and_navigationbar({Key? key}) : super(key: key);
  @override
  State<appbar_and_navigationbar> createState() => _appbar_and_navigationbarState();
}
class _appbar_and_navigationbarState extends State<appbar_and_navigationbar> {
  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const CircleAvatar(
          backgroundImage: AssetImage("assets/logo.png"),
          radius: 16, // Reduce radius
        ),
        actions: [
          const Text(
            "OnStream",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 120),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context)=>MovieSearchPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // Implement account functionality here
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Set type to fixed
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle, color: Colors.white),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder, color: Colors.white),
            label: 'TV series',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later, color: Colors.white),
            label: 'Watch later',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.read_more_outlined, color: Colors.white),
            label: 'More',
          ),
        ],
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white54,
      ),
      body: Screen_Navigations(),
    );
  }
  Widget Screen_Navigations() {
    switch (_currentIndex) {
      case 1:
        return  const MoviesScreen();
      case 2:
      // Return the TV series screen here
        return Tvseries();
      case 3:
      // Return the watch later screen here
        return WatchLaterScreen();
      case 4:
      // Return the more options screen here
        return Moreoption();
      default:
        return const Homepage();
    }
  }
}
