import 'package:flutter/material.dart';

class LikePage extends StatelessWidget {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchAppScreen(),
    );
  }
}

class SearchAppScreen extends StatefulWidget {
  const SearchAppScreen({Key? key}) : super(key: key);

  @override
  State<SearchAppScreen> createState() => _SearchAppScreenState();
}

class _SearchAppScreenState extends State<SearchAppScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Active subscription are displayed here",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
