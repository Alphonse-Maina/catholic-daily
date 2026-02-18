import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class SaintsService {
  List<Map<String, dynamic>> _saints = [];

  Future<void> loadSaints() async {
    final data = await rootBundle.loadString('assets/data/saints.json');
    final jsonData = json.decode(data) as List<dynamic>;
    _saints = jsonData.map((e) => e as Map<String, dynamic>).toList();
  }

  Map<String, dynamic>? getSaintOfTheDay() {
    final today = DateTime.now();
    return _saints.firstWhere(
          (s) =>
      int.parse(s['month_num']) == today.month &&
          int.parse(s['saint_day']) == today.day,
      orElse: () => {},
    );
  }
}
