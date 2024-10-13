import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favoriteWebtoons = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favs = [];

    // Load favorite webtoons from SharedPreferences
    for (var key in prefs.getKeys()) {
      if (key.endsWith('_favorite') && prefs.getBool(key) == true) {
        String webtoon = key.replaceAll('_favorite', '');
        favs.add(webtoon);
      }
    }

    setState(() {
      favoriteWebtoons = favs;
    });
  }

  _removeFromFavorites(String webtoon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteWebtoons.remove(webtoon);
      prefs.remove('${webtoon}_favorite');
      prefs.remove('${webtoon}_rating'); // Clear the rating if necessary
    });
  }

  String _getThumbnailPath(String webtoon) {
    // Ensure consistent image path
    return 'images/${webtoon.toLowerCase().replaceAll(' ', '_')}.jpg';
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 800 ? 2 : 4;

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favoriteWebtoons.isEmpty
          ? Center(child: Text('No favorites yet!'))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75,
          ),
          itemCount: favoriteWebtoons.length,
          itemBuilder: (context, index) {
            String webtoon = favoriteWebtoons[index];
            String thumbnail = _getThumbnailPath(webtoon);

            return GestureDetector(
              onTap: () {
                // Navigate to DetailScreen (you can pass the description as well if needed)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      webtoon: webtoon,
                      thumbnail: thumbnail,
                      description: null, // Set description to null if not needed
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: Center(child: Text('Image not found')),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    webtoon,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _removeFromFavorites(webtoon);
                    },
                    child: Text('Remove from Favorites'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
