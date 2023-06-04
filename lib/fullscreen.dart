// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> sethomescreen() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);

    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  Future<void> setlockscreen() async {
    int location2 = WallpaperManager.LOCK_SCREEN;
    var file2 = await DefaultCacheManager().getSingleFile(widget.imageUrl);

    bool result2 =
        await WallpaperManager.setWallpaperFromFile(file2.path, location2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imageUrl),
              ),
            ),
            InkWell(
              onTap: () {
                sethomescreen();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text("Wallpaper Set"),
                  ),
                );
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                ),
                // wrap text in centre not container
                child: Center(
                  child: Text(
                    "Set as Home Screen",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setlockscreen();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text("Wallpaper Set"),
                  ),
                );
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                ),
                // wrap text in centre not container
                child: Center(
                  child: Text(
                    "Set as Lock Screen",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
