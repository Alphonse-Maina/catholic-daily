import 'package:flutter/material.dart';
import '../data/rosary_loader.dart';
import '../models/mystery.dart';
import '../services/daily_theme_service.dart';
import 'prayer_screen.dart';

class RosaryScreen extends StatefulWidget {
  const RosaryScreen({super.key});

  @override
  State<RosaryScreen> createState() => _RosaryScreenState();
}

class _RosaryScreenState extends State<RosaryScreen> {
  List<Mystery> todayMysteries = [];
  Color themeColor = Colors.blue; // default

  @override
  void initState() {
    super.initState();
    _loadTodaysMysteries();
  }

  Future<void> _loadTodaysMysteries() async {
    final mysteries = await RosaryLoader.loadMysteriesForToday();
    final color = DailyThemeService.instance.themeColor;

    setState(() {
      todayMysteries = mysteries;
      themeColor = color;
    });
  }

  Color getLiturgicalColor(DateTime date) {
    switch (date.weekday) {
      case DateTime.sunday:
        return Colors.white; // Glorious
      case DateTime.monday:
        return Colors.purple; // Sorrowful
      case DateTime.tuesday:
        return Colors.yellow; // Joyful
      case DateTime.wednesday:
        return Colors.white; // Glorious
      case DateTime.thursday:
        return Colors.blue; // Luminous
      case DateTime.friday:
        return Colors.red; // Sorrowful
      case DateTime.saturday:
        return Colors.yellow; // Joyful
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today's Mysteries"),
        backgroundColor: themeColor,
      ),
      body: todayMysteries.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: todayMysteries.length,
        itemBuilder: (context, index) {
          final mystery = todayMysteries[index];
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
                      mysteries: todayMysteries,
                      themeColor: themeColor,
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
                              color: themeColor.withOpacity(0.8),
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
