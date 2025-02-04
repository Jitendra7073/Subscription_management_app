import 'package:flutter/material.dart';
import '../components/search_bar.dart';
import '../pages/AddSubscriptionPage.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> subscriptions = [
    {"name": "Netflix", "date": "31 Jan", "icon": "assets/logos/netflix.png"},
    {"name": "Spotify", "date": "01 Feb", "icon": "assets/logos/spotify.png"},
    {"name": "YouTube", "date": "28 Feb", "icon": "assets/logos/youtube.png"},
    {
      "name": "Amazon Music",
      "date": "01 Mar",
      "icon": "assets/logos/amazon-music.png"
    },
  ];
  List<Map<String, String>> filteredSubscriptions = [];

  @override
  void initState() {
    super.initState();
    filteredSubscriptions = subscriptions;
  }

  void _filterSubscriptions(String query) {
    setState(() {
      filteredSubscriptions = subscriptions
          .where(
              (sub) => sub["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   child: SearchFunction(),
            // ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Average monthly expense",
                      style: TextStyle(color: Colors.white)),
                  Text("0000.00",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: null,
                    child: Text("Active Subscriptions"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _summaryCard("00", "Total Subscriptions", Colors.blue),
                _summaryCard("00", "Payments this week", Colors.orange),
                _summaryCard("00", "Ongoing free trials", Colors.purple),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Upcoming payments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: filteredSubscriptions.length,
                itemBuilder: (context, index) {
                  var sub = filteredSubscriptions[index];
                  return ListTile(
                    leading: Image.asset(sub["icon"]!, width: 40, height: 40),
                    title: Text(sub["name"]!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: const Text("₹ 0.00/month"),
                    trailing: Text(sub["date"]!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddSubscriptionScreen()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _summaryCard(String value, String title, Color color) {
    return Container(
      width: 120,
      height: 100,
      padding: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
