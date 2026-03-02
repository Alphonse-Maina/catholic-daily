class SevenSorrows {
  final String title;
  final List<String> howToPray;
  final List<Sorrow> sorrows;
  final String closingPrayer;

  SevenSorrows({
    required this.title,
    required this.howToPray,
    required this.sorrows,
    required this.closingPrayer,
  });

  factory SevenSorrows.fromJson(Map<String, dynamic> json) {
    return SevenSorrows(
      title: json['title'],
      howToPray: List<String>.from(json['how_to_pray']),
      sorrows: (json['sorrows'] as List)
          .map((s) => Sorrow.fromJson(s))
          .toList(),
      closingPrayer: json['closing_prayer'],
    );
  }
}

class Sorrow {
  final String title;
  final String scripture;
  final String meditation;

  Sorrow({
    required this.title,
    required this.scripture,
    required this.meditation,
  });

  factory Sorrow.fromJson(Map<String, dynamic> json) {
    return Sorrow(
      title: json['title'],
      scripture: json['scripture'],
      meditation: json['meditation'],
    );
  }
}