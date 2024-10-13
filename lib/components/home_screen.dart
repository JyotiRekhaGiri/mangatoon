import 'package:flutter/material.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> webtoonDetails = [
    {
      'title': 'Lore Olympus',
      'thumbnail': 'images/lore_olympus.jpg',
      'description': 'A modern retelling of the relationship between Hades and Persephone, "Lore Olympus" brings Greek mythology into a contemporary setting with stunning artwork and emotionally gripping storytelling.'
    },
    {
      'title': 'Tower of God',
      'thumbnail': 'images/tower_of_god.jpg',
      'description': 'Follow the journey of Bam as he enters the mysterious Tower, facing deadly tests and powerful foes to find his beloved Rachel. The story delves deep into the mysteries of the Tower and its inhabitants.'
    },
    {
      'title': 'Solo Leveling',
      'thumbnail': 'images/solo_leveling.jpeg',
      'description': 'In a world where hunters battle monsters for survival, Sung Jin-Woo starts as the weakest of all but gains the ability to "level up" infinitely, becoming a force unlike any other.'
    },
    {
      'title': 'The God of High School',
      'thumbnail': 'images/god_of_high_school.jpg',
      'description': 'Martial artists from across the world compete in the God of High School tournament, where the winner is granted anything they wish. But the stakes are much higher than anyone imagined.'
    },
    {
      'title': 'True Beauty',
      'thumbnail': 'images/true_beauty.webp',
      'description': 'After mastering the art of makeup, Jugyeong transforms from an ordinary girl to a beautiful social media star. But can she keep her true self hidden from those closest to her?'
    },
    {
      'title': 'Unordinary',
      'thumbnail': 'images/unordinary.jpg',
      'description': 'In a world where superpowers are the norm, John, a powerless teenager, navigates the dangerous school hierarchy while hiding a secret that could change everything.'
    },
    {
      'title': 'Sweet Home',
      'thumbnail': 'images/sweet_home.webp',
      'description': 'After a personal tragedy, Hyun Cha retreats to his apartment, only to face an apocalypse where people turn into horrific monsters. He must fight to survive while confronting his own inner demons.'
    },
    {
      'title': 'Noblesse',
      'thumbnail': 'images/noblesse.jpg',
      'description': 'Rai, a powerful and ancient vampire known as a Noblesse, awakens after centuries of slumber and must protect the world from supernatural threats while adjusting to modern life.'
    },
    {
      'title': 'Omniscient Reader',
      'thumbnail': 'images/omniscient_reader.jpeg',
      'description': 'Dokja, an ordinary reader of an obscure web novel, finds himself in the midst of the story’s apocalyptic events. Armed with his knowledge of the plot, he fights to survive and influence the unfolding narrative.'
    },
    {
      'title': 'The Beginning After the End',
      'thumbnail': 'images/beginning_after_end.jpg',
      'description': 'King Grey, a powerful monarch, reincarnates in a world filled with magic and monsters. Determined to right the wrongs of his past life, he embarks on a journey of self-discovery and redemption.'
    },
    {
      'title': 'I Love Yoo',
      'thumbnail': 'images/i_love_yoo.jpg',
      'description': 'Shin-Ae has no interest in romance, yet her life becomes entangled with two brothers who have very different personalities. A touching story of love, family, and personal growth.'
    },
    {
      'title': 'Let’s Play',
      'thumbnail': 'images/lets_play.jpg',
      'description': 'Sam, an aspiring game developer, faces online criticism from a famous YouTuber who unknowingly moves in next door. As they confront each other, an unlikely relationship forms.'
    },
    {
      'title': 'The Remarried Empress',
      'thumbnail': 'images/remarried_empress.webp',
      'description': 'After a heartbreaking betrayal by her husband, Empress Navier chooses to divorce him and marry the King of the neighboring empire. A tale of strength, politics, and romance.'
    },
    {
      'title': 'My Deepest Secret',
      'thumbnail': 'images/my_deepest_secret.png',
      'description': 'Emma appears to have the perfect boyfriend, Elios, but he hides dark secrets. The story unravels a psychological thriller of obsession, lies, and hidden dangers.'
    },
    {
      'title': 'The Boxer',
      'thumbnail': 'images/the_boxer.webp',
      'description': 'The story follows Yu, an emotionless boxing prodigy, and explores the physical and mental toll of being an unstoppable fighter in the brutal world of professional boxing.'
    },
    {
      'title': 'Purple Hyacinth',
      'thumbnail': 'images/purple_hyacinth.jpg',
      'description': 'Detective Lauren Sinclair teams up with the infamous assassin, Kieran, to stop a mysterious criminal organization. A blend of action, mystery, and intrigue.'
    },
    {
      'title': 'Eleceed',
      'thumbnail': 'images/eleceed.jpeg',
      'description': 'Jiwoo, a kind-hearted boy with super speed, teams up with Kayden, a powerful cat-like being, to battle evil forces in a world where unique abilities are the key to survival.'
    },
    {
      'title': 'Your Throne',
      'thumbnail': 'images/your_throne.jpeg',
      'description': 'In a kingdom where power determines everything, Lady Medea is determined to reclaim her rightful place after being replaced by the beloved Crown Princess. A story of revenge and intrigue.'
    },
    {
      'title': 'The Witch and the Bull',
      'thumbnail': 'images/witch_and_bull.jpeg',
      'description': 'A powerful witch and a cursed prince must set aside their differences to undo his transformation into a bull. A magical journey filled with humor, romance, and adventure.'
    },
    {
      'title': 'SubZero',
      'thumbnail': 'images/subzero.jpg',
      'description': 'To ensure peace between warring clans, Clove, the last princess of the nearly extinct Azure Dragon Clan, must marry the leader of the Crimson Dragon Clan, a powerful man she fears.'
    }
  ];


  Map<String, bool> favorites = {};
  Map<String, double> ratings = {};

  @override
  void initState() {
    super.initState();
    _loadFavoritesAndRatings();
  }

  _loadFavoritesAndRatings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, bool> loadedFavorites = {};
    Map<String, double> loadedRatings = {};

    for (var webtoon in webtoonDetails) {
      String title = webtoon['title']!;
      bool isFavorite = prefs.getBool('${title}_favorite') ?? false;
      double rating = prefs.getDouble('${title}_rating') ?? 0.0;

      loadedFavorites[title] = isFavorite;
      loadedRatings[title] = rating;
    }

    setState(() {
      favorites = loadedFavorites;
      ratings = loadedRatings;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 800 ? 2 : 4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Webtoon Explorer'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.75,
          ),
          itemCount: webtoonDetails.length,
          itemBuilder: (context, index) {
            String title = webtoonDetails[index]['title']!;
            String thumbnail = webtoonDetails[index]['thumbnail']!;
            String description = webtoonDetails[index]['description']!;

            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      webtoon: title,
                      thumbnail: thumbnail,
                      description: description,
                    ),
                  ),
                );
                _loadFavoritesAndRatings(); // Reload favorites and ratings after returning from DetailScreen
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
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  if (favorites[title] == true)
                    Icon(Icons.favorite, color: Colors.red),
                  Text(
                    'Rating: ${ratings[title]?.toStringAsFixed(1) ?? 'N/A'}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0),
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