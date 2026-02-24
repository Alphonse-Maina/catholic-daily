import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:hive/hive.dart';

class ReadingsService {
  final Box _box = Hive.box('dailyReadings');

  String _formatKey(DateTime date) {
    return date.toIso8601String().split('T').first; // yyyy-MM-dd
  }

  String _formatUrl(DateTime date) {
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    final yy = date.year.toString().substring(2);
    return "https://bible.usccb.org/bible/readings/$mm$dd$yy.cfm";
  }

  /// 🔹 Fetch reading for specific date (used for syncing)
  Future<Map<String, String>> fetchReadingForDate(DateTime date) async {
    final url = _formatUrl(date);
    final Map<String, String> readingsMap = {};

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode != 200) return readingsMap;

      final doc = parse(res.body);
      final blocks = doc.querySelectorAll('div.wr-block.b-verse');

      for (var block in blocks) {
        final titleElem =
        block.querySelector('div.content-header h3.name');
        if (titleElem == null) continue;
        final title = titleElem.text.trim();

        final bodyElem = block.querySelector('div.content-body');
        if (bodyElem == null) continue;

        String cleanText(String html) {
          String text = html.replaceAll('<br>', '\n');
          text = text.replaceAll(RegExp(r'\u00a0'), ' ');
          text = text.replaceAll(RegExp(r'\s+\n'), '\n');
          text = text.replaceAll(RegExp(r'\n\s+'), '\n');
          text = text.replaceAll(RegExp(r'\s{2,}'), ' ');
          return parse(text).body?.text.trim() ?? '';
        }

        if (title.toLowerCase().contains('responsorial psalm')) {
          final firstP = bodyElem.querySelector('p');
          String response = '';
          String verses = '';

          if (firstP != null) {
            final strong = firstP.querySelector('strong');
            if (strong != null) {
              response = strong.text.trim();
            }

            final pCopy = firstP.clone(true);
            pCopy.querySelectorAll('strong').forEach((e) => e.remove());

            verses = pCopy.text
                .replaceAll(RegExp(r'R\.\s*'), '')
                .replaceAll(RegExp(r'\u00a0'), ' ')
                .replaceAll(RegExp(r'\s+'), ' ')
                .trim();
          }

          readingsMap[title] = 'Response: $response\n\n$verses';
        } else {
          final text = bodyElem
              .querySelectorAll('p')
              .map((p) => cleanText(p.innerHtml))
              .join('\n\n');

          readingsMap[title] = text;
        }
      }
    } catch (e) {
      print("Error fetching readings: $e");
    }

    return readingsMap;
  }

  /// 🔹 Sync next 30 days (call when online)
  Future<void> syncNext30Days() async {
    final today = DateTime.now();

    // Delete old readings
    final keysToDelete = _box.keys.where((key) {
      final date = DateTime.parse(key);
      return date.isBefore(today);
    }).toList();

    for (var key in keysToDelete) {
      await _box.delete(key);
    }

    // Fetch next 30 days
    for (int i = 0; i < 30; i++) {
      final date = today.add(Duration(days: i));
      final key = _formatKey(date);

      if (!_box.containsKey(key)) {
        final readings = await fetchReadingForDate(date);
        if (readings.isNotEmpty) {
          await _box.put(key, readings);
        }
      }
    }
  }

  /// 🔹 Get reading from Hive (used by Home)
  Map<String, String>? getTodayReadings() {
    final key = _formatKey(DateTime.now());
    final data = _box.get(key);
    if (data == null) return null;
    return Map<String, String>.from(data);
  }
}