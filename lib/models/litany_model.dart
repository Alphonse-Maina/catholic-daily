class Litany {
  final String title;
  final String? subtitle;
  final String body;
  final String? closingPrayer;

  Litany({
    required this.title,
    this.subtitle,
    required this.body,
    this.closingPrayer,
  });

  factory Litany.fromJson(Map<String, dynamic> json) {
    return Litany(
      title: json['title'],
      subtitle: json['subtitle'],
      body: json['body'],
      closingPrayer: json['closing_prayer'],
    );
  }
}