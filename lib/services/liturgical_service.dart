import '../models/liturgical_day.dart';

class LiturgicalService {

  DateTime calculateEaster(int year) {
    int a = year % 19;
    int b = year ~/ 100;
    int c = year % 100;
    int d = b ~/ 4;
    int e = b % 4;
    int f = (b + 8) ~/ 25;
    int g = (b - f + 1) ~/ 3;
    int h = (19 * a + b - d - g + 15) % 30;
    int i = c ~/ 4;
    int k = c % 4;
    int l = (32 + 2 * e + 2 * i - h - k) % 7;
    int m = (a + 11 * h + 22 * l) ~/ 451;
    int month = (h + l - 7 * m + 114) ~/ 31;
    int day = ((h + l - 7 * m + 114) % 31) + 1;

    return DateTime(year, month, day);
  }

  LiturgicalDay getDay(DateTime date) {
    final easter = calculateEaster(date.year);

    final ashWednesday = easter.subtract(const Duration(days: 46));
    final pentecost = easter.add(const Duration(days: 49));
    final christmas = DateTime(date.year, 12, 25);
    final adventStart =
    christmas.subtract(Duration(days: christmas.weekday + 21));

    if (date.isAfter(ashWednesday) && date.isBefore(easter)) {
      return LiturgicalDay(
        season: "Lent",
        color: "Violet",
        celebration: "Lenten Weekday",
      );
    }

    if (date.isAtSameMomentAs(easter)) {
      return LiturgicalDay(
        season: "Easter",
        color: "White",
        celebration: "Easter Sunday",
      );
    }

    if (date.isAfter(easter) && date.isBefore(pentecost)) {
      return LiturgicalDay(
        season: "Easter Season",
        color: "White",
        celebration: "Easter Weekday",
      );
    }

    if (date.isAfter(pentecost) && date.isBefore(adventStart)) {
      return LiturgicalDay(
        season: "Ordinary Time",
        color: "Green",
        celebration: "Weekday",
      );
    }

    if (date.isAfter(adventStart) && date.isBefore(christmas)) {
      return LiturgicalDay(
        season: "Advent",
        color: "Violet",
        celebration: "Advent Weekday",
      );
    }

    return LiturgicalDay(
      season: "Christmas Season",
      color: "White",
      celebration: "Christmas Week",
    );
  }
}
