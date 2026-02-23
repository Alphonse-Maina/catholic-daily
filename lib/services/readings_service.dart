import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:html/dom.dart';

class ReadingsService {
  Future<Map<String, String>> fetchTodayReadings() async {
    final now = DateTime.now();
    final mm = now.month.toString().padLeft(2, '0');
    final dd = now.day.toString().padLeft(2, '0');
    final yy = now.year.toString().substring(2);

    final url = "https://bible.usccb.org/bible/readings/$mm$dd$yy.cfm";

    final Map<String, String> readingsMap = {};

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode != 200) return readingsMap;

      final doc = parse(res.body);

      final blocks = doc.querySelectorAll('div.wr-block.b-verse');

      for (var block in blocks) {
        final titleElem = block.querySelector('div.content-header h3.name');
        if (titleElem == null) continue;
        final title = titleElem.text.trim();

        final bodyElem = block.querySelector('div.content-body');
        if (bodyElem == null) continue;

        String cleanText(String html) {
          // Replace <br> with \n
          String text = html.replaceAll('<br>', '\n');
          // Remove &nbsp; and other extra spaces
          text = text.replaceAll(RegExp(r'\u00a0'), ' ');
          text = text.replaceAll(RegExp(r'\s+\n'), '\n'); // spaces before line break
          text = text.replaceAll(RegExp(r'\n\s+'), '\n'); // spaces after line break
          text = text.replaceAll(RegExp(r'\s{2,}'), ' '); // multiple spaces to one
          return text.trim();
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
            verses = pCopy.text .replaceAll(RegExp(r'R\.\s*'), '')// remove repeated "R."
            .replaceAll(RegExp(r'\u00a0'), ' ')// replace &nbsp;
            .replaceAll(RegExp(r'\s+'), ' ') // normalize spaces
            .replaceAll('<br>', '\n') // keep line breaks
            .trim();
          }

          readingsMap[title] = 'Response: $response\n\n$verses';
        } else {
          final text = bodyElem.querySelectorAll('p').map((p) {
            return cleanText(p.innerHtml);
          }).join('\n\n');

          readingsMap[title] = text;
        }
      }
    } catch (e) {
      print("Error fetching readings: $e");
    }

    return readingsMap;
  }
}