import 'package:flutter/material.dart';
import 'components/home_screen.dart';
import 'components/favorites_screen.dart';

void main() {
  runApp(WebtoonApp());
}

class WebtoonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webtoon Explorer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, // This removes the debug banner
      routes: {
        '/favorites': (context) => FavoritesScreen(),
      },
    );
  }
}
