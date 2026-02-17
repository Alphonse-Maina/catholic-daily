import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/mystery.dart';

class RosaryLoader {
  static Future<Map<String, List<Mystery>>> loadAllMysteries() async {
    final jsonString = await rootBundle.loadString('lib/data/rosary_mysteries.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    Map<String, List<Mystery>> mysteriesMap = {};

    jsonMap.forEach((key, value) {
      final List<Mystery> list = (value as List)
          .map((item) => Mystery(
        title: item['title'],
        imageAsset: item['image'],
        shortDescription: item['shortDescription'],
        bibleReference: item['bibleReference'],
      ))
          .toList();
      mysteriesMap[key] = list;
    });

    return mysteriesMap;
  }

  // Determine today's mystery set
  static Future<List<Mystery>> loadMysteriesForToday() async {
    final allMysteries = await loadAllMysteries();
    final weekday = DateTime.now().weekday;

    switch (weekday) {
      case DateTime.monday:
      case DateTime.friday:
        return allMysteries['sorrowful']!;
      case DateTime.tuesday:
      case DateTime.saturday:
        return allMysteries['joyful']!;
      case DateTime.wednesday:
      case DateTime.sunday:
        return allMysteries['glorious']!;
      case DateTime.thursday:
        return allMysteries['luminous']!;
      default:
        return allMysteries['joyful']!;
    }
  }
}
