import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class PrayersPage extends StatefulWidget {
  const PrayersPage({Key? key}) : super(key: key);

  @override
  State<PrayersPage> createState() => _PrayersPageState();
}

class _PrayersPageState extends State<PrayersPage> {
  Map<String, dynamic>? prayersData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPrayers();
  }

  Future<void> loadPrayers() async {
    final String jsonString =
    await rootBundle.loadString('lib/data/prayers.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      prayersData = jsonData;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catholic Prayers'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: prayersData!['prayers'].length,
        itemBuilder: (context, index) {
          final category = prayersData!['prayers'][index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ExpansionTile(
              title: Text(
                category['category'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              children: List.generate(category['items'].length, (i) {
                final prayer = category['items'][i];
                return ListTile(
                  title: Text(
                    prayer['title'],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PrayerDetailPage(prayer: prayer),
                      ),
                    );
                  },
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

class PrayerDetailPage extends StatelessWidget {
  final Map<String, dynamic> prayer;
  const PrayerDetailPage({Key? key, required this.prayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prayer['title']),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            prayer['text'],
            style: const TextStyle(fontSize: 18, height: 1.5),
          ),
        ),
      ),
    );
  }
}
