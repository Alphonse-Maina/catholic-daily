class DailyVerse {
  static Map getToday() {
    final day = DateTime.now().day;

    final readings = [
      {"ref": "John 3:16", "text": "For God so loved the world..."},
      {"ref": "Psalm 23:1", "text": "The Lord is my shepherd..."},
    ];

    return readings[day % readings.length];
  }
}
