import 'package:catholic_daily/services/daily_reading.dart';
import 'package:flutter/material.dart';
import '../models/daily_readings.dart';
import '../services/daily_theme_service.dart';
import '../services/reading_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> saints = [
    "St. Peter",
    "St. Paul",
    "St. Therese",
    "St. Francis",
    "St. Joseph",
    "St. Anthony",
    "St. Mary"
  ];

  final ReadingService readingService = ReadingService();

  @override
  Widget build(BuildContext context) {
    final themeColor = DailyThemeService.instance.themeColor;
    int today = DateTime.now().weekday;
    String saint = saints[today - 1];

    // MVP: save sample reading if not exists
    if (readingService.getTodayReading() == null) {
      readingService.saveTodayReading(DailyReading(
        firstReading: "Genesis 1:1-5",
        psalm: "Psalm 23",
        secondReading: "Romans 5:12-19",
        gospel: "John 1:1-14",
      ));
    }

    final reading = readingService.getTodayReading()!;
    final verse = DailyVerse.getToday();


    return Scaffold(
      backgroundColor: themeColor.withOpacity(0.05),
      appBar: AppBar(
        title: Text("Catholic Daily"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              color: themeColor.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Saint of the Day",
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      saint,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("First Reading: ${reading.firstReading}"),
                    Text("Psalm: ${reading.psalm}"),
                    Text("Second Reading: ${reading.secondReading}"),
                    Text("Gospel: ${reading.gospel}"),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("Daily Verse",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      verse["text"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      verse["ref"],
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
