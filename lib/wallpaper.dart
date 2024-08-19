import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/fullscreen.dart';

class WallpaperScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const WallpaperScreen({super.key, required this.toggleTheme});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  List images = [];
  List categories = ["Nature", "Abstract", "Technology"];
  int page = 1;
  bool isLoading = false;
  String selectedCategory = "Nature";

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    setState(() {
      isLoading = true;
    });
    await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$selectedCategory&per_page=80'),
        headers: {
          'Authorization':
              'cSMyOIGQhS3NnUtCcBOJ9i3WTc20sjHXTPbScLtjha5XVEui3pBT6J7T'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
        isLoading = false;
      });
    });
  }

  loadMore() async {
    setState(() async {
      page = page + 1;
      String Url =
          'https://api.pexels.com/v1/search?query=$selectedCategory&per_page=80&page=' +
              page.toString();
      await http.get(Uri.parse(Url), headers: {
        'Authorization':
            'cSMyOIGQhS3NnUtCcBOJ9i3WTc20sjHXTPbScLtjha5XVEui3pBT6J7T'
      }).then((value) {
        Map result = jsonDecode(value.body);
        setState(() {
          images.addAll(result['photos']);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpapers'),
        actions: [
          IconButton(
            icon: Icon(Icons.nightlight_round),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                      page = 1;
                      fetchApi();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index]
                          ? Colors.black
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Expanded(
                  child: GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 2,
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 3,
                        mainAxisSpacing: 2),
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreen(
                                imageUrl: images[index]['src']['large2x'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
          InkWell(
            onTap: () {
              loadMore();
            },
            child: Container(
              height: 90,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Load More",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
