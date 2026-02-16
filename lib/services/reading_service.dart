import 'package:hive/hive.dart';
import '../models/daily_readings.dart';

class ReadingService {
  final Box _box = Hive.box('dailyReadings');

  String _todayKey() {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  DailyReading? getTodayReading() {
    final key = _todayKey();
    if (_box.containsKey(key)) {
      return DailyReading.fromMap(Map<String, String>.from(_box.get(key)));
    }
    return null;
  }

  void saveTodayReading(DailyReading reading) {
    final key = _todayKey();
    _box.put(key, reading.toMap());
  }
}
