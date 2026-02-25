import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DailyVerseService {
  static Future<Map<String, String>> getVerseForDate(DateTime date) async {
    final jsonString =
    await rootBundle.loadString('lib/data/daily_verses.json');

    final List verses = json.decode(jsonString);

    final dayOfYear = int.parse(DateFormat("D").format(date));
    final index = dayOfYear % verses.length;

    return {
      "reference": verses[index]["reference"],
      "text": verses[index]["text"],
    };
  }

  static Future<Map<String, String>> getTodayVerse() async {
    return getVerseForDate(DateTime.now());
  }
}