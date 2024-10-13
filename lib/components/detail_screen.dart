import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final String webtoon;
  final String thumbnail;
  final String? description; // Make description optional

  DetailScreen({
    required this.webtoon,
    required this.thumbnail,
    this.description,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;
  double currentRating = 0.0;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    _loadRating();
  }

  _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('${widget.webtoon}_favorite') ?? false;
    });
  }

  _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
      prefs.setBool('${widget.webtoon}_favorite', isFavorite);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(isFavorite
          ? '${widget.webtoon} added to favorites!'
          : '${widget.webtoon} removed from favorites!'),
    ));
  }

  _loadRating() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentRating = prefs.getDouble('${widget.webtoon}_rating') ?? 0.0;
    });
  }

  _setRating(double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentRating = rating;
      prefs.setDouble('${widget.webtoon}_rating', rating);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.webtoon)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the webtoon title first
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.webtoon,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Title style
              ),
            ),
            // Image displayed second
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  widget.thumbnail,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Display the description next
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.description ?? 'No description available', // Fallback for null
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: _toggleFavorite,
              child: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Rate this webtoon:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Slider(
              value: currentRating,
              onChanged: _setRating,
              min: 0,
              max: 5,
              divisions: 5,
              label: currentRating.toString(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Current Rating: $currentRating',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
