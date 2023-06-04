// ignore_for_file: prefer_const_constructors, 
//avoid_web_libraries_in_flutter, avoid_print


import 'package:flutter/material.dart';
import 'package:wallpaper_app/wallpaper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: WallpaperScreen(),
    );
  }
}
