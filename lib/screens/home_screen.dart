import 'package:flutter/material.dart';
import '../models/daily_readings.dart';
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

  final Map<int, Color> liturgicalColors = {
    1: Colors.green,
    2: Colors.green,
    3: Colors.green,
    4: Colors.purple,
    5: Colors.red,
    6: Colors.white,
    7: Colors.white,
  };

  final ReadingService readingService = ReadingService();

  @override
  Widget build(BuildContext context) {
    int today = DateTime.now().weekday;
    String saint = saints[today - 1];
    Color color = liturgicalColors[today]!;

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

    return Scaffold(
      appBar: AppBar(
        title: Text("Catholic Daily"),
        backgroundColor: color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              color: color.withOpacity(0.2),
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
          ],
        ),
      ),
    );
  }
}
