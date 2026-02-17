import 'package:flutter/material.dart';

class DailyThemeService {
  DailyThemeService._privateConstructor();
  static final DailyThemeService instance = DailyThemeService._privateConstructor();

  /// Map weekday (1=Mon..7=Sun) → Rosary type
  final Map<int, String> mysteryTypeByDay = {
    1: "Joyful",
    2: "Sorrowful",
    3: "Glorious",
    4: "Luminous",
    5: "Sorrowful",
    6: "Joyful",
    7: "Glorious",
  };

  /// Map weekday → Liturgical color
  final Map<int, Color> themeColorByDay = {
    1: Colors.blue,      // Monday
    2: Colors.red,       // Tuesday
    3: Colors.purple,    // Wednesday
    4: Colors.white,     // Thursday
    5: Colors.red,       // Friday
    6: Colors.blue,      // Saturday
    7: Colors.purple,    // Sunday
  };

  int get todayWeekday => DateTime.now().weekday;

  String get todayMysteryType => mysteryTypeByDay[todayWeekday]!;

  Color get themeColor => themeColorByDay[todayWeekday]!;

  /// Optional: pass a date if needed
  String mysteryTypeForDate(DateTime date) => mysteryTypeByDay[date.weekday]!;

  Color themeColorForDate(DateTime date) => themeColorByDay[date.weekday]!;
}
