import 'package:flutter/material.dart';
import '../components/search_bar.dart';
import '../components/image_slider.dart';
import '../components/apps_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> searchResults = [];
  List<Map<String, String>> popularApps = [
    // Music
    {
      'name': 'Spotify',
      'icon': 'assets/logos/spotify.png',
      'category': 'Music'
    },
    {
      'name': 'Apple Music',
      'icon': 'assets/logos/apple-music.png',
      'category': 'Music'
    },
    {
      'name': 'Amazon Music',
      'icon': 'assets/logos/amazon-music.png',
      'category': 'Music'
    },

    // Streaming
    {
      'name': 'Netflix',
      'icon': 'assets/logos/netflix.png',
      'category': 'Streaming'
    },
    {'name': 'Hulu', 'icon': 'assets/logos/hulu.png', 'category': 'Streaming'},
    {
      'name': 'Disney+',
      'icon': 'assets/logos/Disney+.png',
      'category': 'Streaming'
    },

    // Gaming
    {
      'name': 'Xbox',
      'icon': 'assets/logos/xbox.png',
      'category': 'Gaming'
    },
    {
      'name': 'Apple Arcade',
      'icon': 'assets/logos/apple-arcade.png',
      'category': 'Gaming'
    },
    {
      'name': 'Google Stadia',
      'icon': 'assets/logos/google-stadia.png',
      'category': 'Gaming'
    },

    // Reading
    {
      'name': 'Kindle',
      'icon': 'assets/logos/kindle.png',
      'category': 'Reading'
    },
    {
      'name': 'Audible',
      'icon': 'assets/logos/audible.png',
      'category': 'Reading'
    },
    {
      'name': 'The New Yorker',
      'icon': 'assets/logos/the-new-yorker.png',
      'category': 'Reading'
    },

    // Social
    {
      'name': 'LinkedIn',
      'icon': 'assets/logos/linkedin.png',
      'category': 'Social'
    },
    {
      'name': 'Reddit',
      'icon': 'assets/logos/reddit.png',
      'category': 'Social'
    },
    {
      'name': 'Tinder',
      'icon': 'assets/logos/Tinder.png',
      'category': 'Social'
    },

    // Education
    {
      'name': 'Coursera',
      'icon': 'assets/logos/coursera.png',
      'category': 'Education'
    },
    {
      'name': 'MasterClass',
      'icon': 'assets/logos/master-class.png',
      'category': 'Education'
    },
    {
      'name': 'Udemy',
      'icon': 'assets/logos/udemy.png',
      'category': 'Education'
    },
  ];

  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    searchResults = popularApps; // Initially show all popular apps
  }

  // void _filterSearchResults(String query) {
  //   if (query.isEmpty) {
  //     setState(() {
  //       searchResults = popularApps;
  //     });
  //   } else {
  //     setState(() {
  //       searchResults = popularApps
  //           .where((app) =>
  //               app['name']!.toLowerCase().contains(query.toLowerCase()))
  //           .toList();
  //     });
  //   }
  // }

  void _filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty && selectedCategory == 'All') {
        searchResults = popularApps;
      } else {
        searchResults = popularApps.where((app) {
          final matchesSearch =
              app['name']!.toLowerCase().contains(query.toLowerCase());
          final matchesCategory =
              selectedCategory == 'All' || app['category'] == selectedCategory;
          return matchesSearch && matchesCategory;
        }).toList();
      }
    });
  }

  void _selectCategory(String category) {
    setState(() {
      selectedCategory = category;
      _filterSearchResults(_searchController
          .text); // Reapply the filter with the current search query
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            SearchFunction(
              searchController: _searchController,
              onSearchChanged: _filterSearchResults,
            ),

            // Image Slider
            const ImageSlider(),

            // Categories Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryItem('All', Icons.border_all),
                    _buildCategoryItem('Music', Icons.music_note),
                    _buildCategoryItem('Streaming', Icons.tv),
                    _buildCategoryItem('Gaming', Icons.videogame_asset),
                    _buildCategoryItem('Reading', Icons.book),
                    _buildCategoryItem('Social', Icons.south_america_outlined),
                    _buildCategoryItem('Education', Icons.school),
                  ],
                ),
              ),
            ),

            // Popular Apps Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Popular Apps',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppsGrid(
                apps: searchResults,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String name, IconData icon) {
    return GestureDetector(
      onTap: () => _selectCategory(name),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor:
                  selectedCategory == name ? Colors.blue : Colors.grey[200],
              child: Icon(icon,
                  color: selectedCategory == name
                      ? Colors.white
                      : Colors.grey[700]),
            ),
            const SizedBox(height: 5),
            Text(name, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
