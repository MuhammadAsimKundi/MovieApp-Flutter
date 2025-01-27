import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/Screens/tv%20series%20screen.dart';
import 'package:movieapp/Screens/watchlater%20controler.dart';
import 'package:provider/provider.dart';
import 'detial screen.dart';
import 'movies.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  String url = "";
  int index1 = 0;
  int index2 = 0;
  String title = "";
  String genre = "";
  String year = "";
  String rating = "";
  String poster_url = "";
  List<dynamic> _jsonData1 = [];
  List<dynamic> _jsonData2 = [];
  List<dynamic> _tvseries = [];
  @override
  void initState() {
    super.initState();
    fetchDataFromLocal();
  }

  Future<void> fetchDataFromLocal() async {
    try {
      // Load the first JSON file from assets
      String jsonString1 = await rootBundle.loadString('assets/json1.json');
      final List<dynamic> data1 = json.decode(jsonString1);

      // Load the second JSON file from assets
      String jsonString2 = await rootBundle.loadString('assets/json2.json');
      final List<dynamic> data2 = json.decode(jsonString2);

      String jsonString3 = await rootBundle.loadString('assets/tvseries.json');
      final List<dynamic> data3 = json.decode(jsonString3);
      // Update state with the loaded data
      setState(() {
        _jsonData1 = data1;
        _jsonData2 = data2;
        _tvseries= data3;
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: buildHomepage(),
    );
  }
  Widget buildHomepage() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
             child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 250.0, // Adjust height as needed
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  pageSnapping: true,
                  autoPlayCurve: Curves. fastOutSlowIn,
                  autoPlay: true, // Disables auto-scrolling
                  viewportFraction: 0.33, // Adjust to control space between items
                  scrollPhysics: ClampingScrollPhysics(),
                  pauseAutoPlayOnTouch: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      index1 = index;
                      title = _jsonData1[index]['name'];
                      genre = (_jsonData1[index]['genre'] as List<dynamic>).join(", ");
                      year = _jsonData1[index]['year'];
                      rating = _jsonData1[index]['ratingValue'];
                      poster_url = _jsonData1[index]['poster_url'];
                    });
                  },
                ),
                itemCount: _jsonData1.length,
                itemBuilder: (context, index, realIndex) {
                  return _buildListItem(context, index);
                },
              ),
            ),
            SizedBox(height: 8), // Adjust the height to reduce space
            Text(
              'Title: $title',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4), // Adjust the height to reduce space
            Text(
              'Movie: $genre',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(
                            title: _jsonData1[index1]['name'],
                            year: _jsonData1[index1]['year'],
                            rating: _jsonData1[index1]['ratingValue'],
                            poster_url: _jsonData1[index1]['poster_url'],
                            summary_text:  _jsonData1[index1]['summary_text'],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.details, color: Colors.white, size: 15),
                        Text("Details", style: TextStyle(fontSize: 15, color: Colors.white54)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => YoutubePlayerScreen(movieName: title),
                        ),
                      );
                    },
                    child: Container(
                      width: 170,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.yellow.shade600,
                      ),
                      child: const Center(
                        child: Text(
                          "Watch Now",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<WatchLaterProvider>
                        (context,listen: false).addToWatchLater(_jsonData1[index1]);
                    },
                    child: const Column(
                      children: [
                        Icon(Icons.watch_later, color: Colors.white, size: 15),
                        Text("Add List", style: TextStyle(fontSize: 15, color: Colors.white54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Movies", style: TextStyle(fontSize: 15, color: Colors.white)),
                TextButton(
                  onPressed: (){
                    Navigator.push(
                  context, MaterialPageRoute(
                        builder: (context)=>MoviesScreen()));
                  },
                  child: Text("View All", style: TextStyle(fontSize: 15, color: Colors.yellow)),
                )
              ],
            ),
            SizedBox(
              height: 150, // Set a fixed height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _jsonData1.length,
                itemBuilder: _buildListItem2,
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Tv series", style: TextStyle(fontSize: 15, color: Colors.white)),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Tvseries()));
                  },
                    child: Text('View all',style: TextStyle(color: Colors.yellow,fontSize: 15)),)
              ],
            ),
            SizedBox(
              height: 150, // Set a fixed height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _tvseries.length,
                itemBuilder: _buildListItem3,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
  Widget _buildListItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              title: _jsonData1[index]['name'],
              year: _jsonData1[index]['year'],
              rating: _jsonData1[index]['ratingValue'],
              poster_url: _jsonData1[index]['poster_url'],
              summary_text:  _jsonData1[index]['summary_text'],

            ),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 250,
        child: Image.network(
          _jsonData1[index]['poster_url'],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildListItem2(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              title: _jsonData2[index]['name'],
              year: _jsonData2[index]['year'],
              rating: _jsonData2[index]['ratingValue'],
              poster_url: _jsonData2[index]['poster_url'],
              summary_text:  _jsonData2[index]['summary_text'],
            ),
          ),
        );
      },
      child: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  _jsonData2[index]['poster_url'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildListItem3(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(
              title: _tvseries[index]['name'],
              year: _tvseries[index]['year'],
              rating: _tvseries[index]['ratingValue'],
              poster_url: _tvseries[index]['poster_url'],
              summary_text:  _tvseries[index]['summary_text'],
            ),
          ),
        );
      },
      child: SizedBox(
        width: 150,
        height: 150,
        child: Column(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  _tvseries[index]['poster_url'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
