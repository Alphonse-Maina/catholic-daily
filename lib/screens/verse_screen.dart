import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../services/bible_database.dart';
import '../services/bookmark_service.dart';
import '../services/highlight_service.dart';

class VerseScreen extends StatefulWidget {
  final int bookId;
  final String bookName;
  final int chapter;
  final Color color;

  const VerseScreen({
    super.key,
    required this.bookId,
    required this.bookName,
    required this.chapter,
    required this.color
  });

  @override
  State<VerseScreen> createState() => _VerseScreenState();
}

class _VerseScreenState extends State<VerseScreen> {
  List<Map<String, dynamic>> verses = [];
  List<int> highlights = [];

  @override
  void initState() {
    super.initState();
    loadVerses();
    loadHighlights();
  }


  Future<void> loadVerses() async {
    final data =
    await BibleDatabase.getVerses(widget.bookId, widget.chapter);
    setState(() => verses = data);
  }
  Future<void> loadHighlights() async {
    highlights = await HighlightService.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: Text("${widget.bookName} ${widget.chapter}"), backgroundColor:widget.color),
      body: verses.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: verses.length,
        itemBuilder: (context, i) {
          final verse = verses[i];

          return GestureDetector(
            onLongPress: () {
              final text =
                  "${widget.bookName} ${widget.chapter}:${verse["verse"]} ${verse["text"]}";

              showModalBottomSheet(
                context: context,
                builder: (_) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.copy),
                      title: const Text("Copy"),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: text));
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: const Text("Share"),
                      onTap: () {
                        Share.share(text);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.bookmark),
                      title: const Text("Bookmark"),
                      onTap: () async {
                        await BookmarkService.add(verse);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.highlight),
                      title: const Text("Highlight"),
                      onTap: () async {
                        await HighlightService.toggle(verse["id"]);
                        await loadHighlights();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: 12),
              color: highlights.contains(verse["id"])
                  ? Colors.yellow.shade200
                  : Colors.transparent,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text: "${verse["verse"]} ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: verse["text"]),
                  ],
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}
