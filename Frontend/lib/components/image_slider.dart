import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<Map<String, String>> imgList = [
    {'name': 'Netflix', 'image': 'assets/images/netflix.jpg'},
    {'name': 'Prime Video', 'image': 'assets/images/prime.jpeg'},
    {'name': 'SonyLIV', 'image': 'assets/images/sonyLIV.jpg'},
    {'name': 'Spotify', 'image': 'assets/images/spotify.jpg'},
  ];

  int _currentIndex = 0;

  void _showMessage(String appName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('you hitted $appName banner')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10.0),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: imgList
                  .map((item) => GestureDetector(
                        onTap: () => _showMessage(item['name']!),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.asset(item['image']!,
                                fit: BoxFit.cover, width: 1200),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((item) {
              int index = imgList.indexOf(item);
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? isDarkMode
                          ? Colors.white70
                          : Colors.grey[600]
                      // : Color.fromRGBO(255, 255, 255, 0.4),
                      : isDarkMode
                          ? Colors.white30
                          : Colors.grey[300],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
