class DailyReading {
  final String firstReading;
  final String psalm;
  final String secondReading;
  final String gospel;

  DailyReading({
    required this.firstReading,
    required this.psalm,
    required this.secondReading,
    required this.gospel,
  });

  Map<String, String> toMap() => {
    'firstReading': firstReading,
    'psalm': psalm,
    'secondReading': secondReading,
    'gospel': gospel,
  };

  factory DailyReading.fromMap(Map map) => DailyReading(
    firstReading: map['firstReading'],
    psalm: map['psalm'],
    secondReading: map['secondReading'],
    gospel: map['gospel'],
  );
}
