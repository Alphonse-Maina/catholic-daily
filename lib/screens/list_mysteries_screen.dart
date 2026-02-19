import 'package:catholic_daily/models/mystery.dart';
import 'package:catholic_daily/screens/prayer_screen.dart';
import 'package:flutter/material.dart';

class ListMysteriesScreen extends StatefulWidget {
  final Color color;
  final List<Mystery> allMysteries;
  final String title;

  const ListMysteriesScreen({
    super.key,
    required this.title,
    required this.allMysteries,
    required this.color,
  });

  @override
  State<ListMysteriesScreen> createState() => _ListMysteriesScreenState();
}

class _ListMysteriesScreenState extends State<ListMysteriesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color.withOpacity(.12),
      appBar: AppBar(
        title: Text("The ${widget.title[0].toUpperCase()}${widget.title.substring(1)} Mysteries"),
        centerTitle: true,
        backgroundColor: widget.color,
      ),
      body: widget.allMysteries.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: widget.allMysteries.length,
        itemBuilder: (context, index) {
          final mystery = widget.allMysteries[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PrayerScreen(
                      mysteries: widget.allMysteries,
                      themeColor: widget.color,
                      reset: true,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12)),
                    child: Image.asset(
                      mystery.imageAsset,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mystery.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mystery.shortDescription,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mystery.bibleReference,
                          style: TextStyle(
                              fontSize: 12,
                              color: widget.color.withOpacity(0.8),
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
