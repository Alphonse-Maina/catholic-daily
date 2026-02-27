import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:hive/hive.dart';

class ReadingsService {
  final Box _box = Hive.box('dailyReadings');

  String _formatKey(DateTime date) =>
      date.toIso8601String().split('T').first;

  String _formatUrl(DateTime date) {
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    final yy = date.year.toString().substring(2);
    return "https://bible.usccb.org/bible/readings/$mm$dd$yy.cfm";
  }

  // 🔥 REAL CLEAN TEXT THAT PRESERVES BREAKS
  String cleanText(String html) {
    html = html.replaceAll('<br/>', '\n');
    html = html.replaceAll('<br />', '\n');
    html = html.replaceAll('<br>', '\n');
    html = html.replaceAll('R.', '\nR.');

    final doc = parse(html);
    String text = doc.body?.text ?? '';

    text = text.replaceAll('\u00a0', ' ');
    text = text.replaceAll(RegExp(r'[ \t]+'), ' ');
    text = text.replaceAll(RegExp(r'\n\s+'), '\n');
    text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return text.trim();
  }

  Future<Map<String, String>> fetchReadingForDate(DateTime date) async {
    final url = _formatUrl(date);
    final Map<String, String> readingsMap = {};

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode != 200) return readingsMap;

      final doc = parse(res.body);

      // 🔹 Celebration + Lectionary
      final celebration = doc.querySelector('h1.page-title')?.text.trim();
      final lectionary = doc.querySelector('.lectionary')?.text.trim();

      if (celebration != null) {
        readingsMap["Celebration"] = celebration;
      }

      if (lectionary != null) {
        readingsMap["Lectionary"] = lectionary;
      }

      final blocks = doc.querySelectorAll('div.wr-block.b-verse');

      for (var block in blocks) {
        final titleElem =
        block.querySelector('div.content-header h3.name');
        final reference = block.querySelector('div.content-header div.address a')?.text.trim() ?? '';
        if (titleElem == null) continue;

        final rawTitle = titleElem.text.trim();
        final bodyElem = block.querySelector('div.content-body');
        if (bodyElem == null) continue;



        final paragraphs = bodyElem.querySelectorAll('p');

        // ============================
        // FIRST READING
        // ============================
        if (rawTitle.contains("Reading 1")) {
          final text = paragraphs
              .map((p) => cleanText(p.innerHtml))
              .join('\n\n');

          readingsMap["First Reading\n$reference"] = text;
        }

        // ============================
        // SECOND READING
        // ============================
        else if (rawTitle.contains("Reading 2")) {
          final text = paragraphs
              .map((p) => cleanText(p.innerHtml))
              .join('\n\n');

          readingsMap["Second Reading\n$reference"] = text;
        }

        // ============================
        // RESPONSORIAL PSALM
        // ============================
        else if (rawTitle
            .toLowerCase()
            .contains("responsorial psalm")) {
          final text = paragraphs
              .map((p) => cleanText(p.innerHtml))
              .join('\n\n');

          readingsMap["Responsorial Psalm\n$reference"] = text;
        }

        // ============================
        // VERSE BEFORE GOSPEL
        // ============================
        else if (rawTitle
            .toLowerCase()
            .contains("verse before the gospel")) {
          final text = paragraphs
              .map((p) => cleanText(p.innerHtml))
              .join('\n\n');

          readingsMap["Gospel Acclamation\n$reference"] =
              text;
        }

        // ============================
        // GOSPEL
        // ============================
        else if (rawTitle.toLowerCase().contains("gospel")) {
          String evangelist = '';

          if (reference.contains("Matthew")) evangelist = "Matthew";
          else if (reference.contains("Mark")) evangelist = "Mark";
          else if (reference.contains("Luke")) evangelist = "Luke";
          else if (reference.contains("John")) evangelist = "John";

          final text = paragraphs
              .map((p) => cleanText(p.innerHtml))
              .join('\n\n');

          readingsMap[
          "A reading from the Holy Gospel according to $evangelist\n$reference"] =
              text;
        }
      }
    } catch (e) {
      print("Error fetching readings: $e");
    }

    return readingsMap;
  }

  Future<void> syncNext30Days() async {
    final today = DateTime.now();

    final keysToDelete = _box.keys.where((key) {
      final date = DateTime.parse(key);
      return date.isBefore(today);
    }).toList();

    for (var key in keysToDelete) {
      await _box.delete(key);
    }

    for (int i = 0; i < 30; i++) {
      final date = today.add(Duration(days: i));
      final key = _formatKey(date);

      final readings = await fetchReadingForDate(date);
      if (readings.isNotEmpty) {
        await _box.put(key, readings);
      }
    }
  }

  Map<String, String>? getTodayReadings() {
    final key = _formatKey(DateTime.now());
    final data = _box.get(key);
    if (data == null) return null;
    return Map<String, String>.from(data);
  }
}