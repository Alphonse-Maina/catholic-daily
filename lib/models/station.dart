class Station {
  final String title;
  final String adoration;
  final String scripture;
  final String meditation;
  final String prayer;
  final String image; // optional image URL/path

  Station({
    required this.title,
    required this.adoration,
    required this.scripture,
    required this.meditation,
    required this.prayer,
    required this.image,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      title: json['title'],
      adoration: json['adoration'],
      scripture: json['scripture'],
      meditation: json['meditation'],
      prayer: json['prayer'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'adoration': adoration,
    'scripture': scripture,
    'meditation': meditation,
    'prayer': prayer,
    'image': image,
  };
}