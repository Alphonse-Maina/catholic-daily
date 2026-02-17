// lib/data/full_prayers.dart

class PrayerLine {
  final String text;
  final PrayerType type;

  PrayerLine({required this.text, required this.type});
}

enum PrayerType { ourFather, hailMary, gloryBe, fatima }

final List<PrayerLine> decadePrayers = [
  PrayerLine(
    text: "Our Father which art in heaven, Hallowed be thy name. Thy kingdom come. Thy will be done in earth, as it is in heaven. Give us this day our daily bread. And forgive us our debts, as we forgive our debtors. And lead us not into temptation, but deliver us from evil. Amen",
    type: PrayerType.ourFather,
  ),
  // 10 Hail Marys
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Hail Mary, full of grace, the Lord is with thee.  Blessed art thou among women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen. ",
    type: PrayerType.hailMary,
  ),
  PrayerLine(
    text: "Glory be to the Father, and to the Son, and to the Holy Spirit.  As it was in the beginning, is now, and ever shall be, world without end. Amen.",
    type: PrayerType.gloryBe,
  ),
  PrayerLine(
    text: "O my Jesus, forgive us our sins, save us from the fires of hell, lead all souls to heaven, especially those most in need of Your mercy.",
    type: PrayerType.fatima,
  ),
];
