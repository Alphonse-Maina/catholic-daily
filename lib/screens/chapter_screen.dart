import 'package:flutter/material.dart';
import '../services/bible_database.dart';
import 'verse_screen.dart';

class ChapterScreen extends StatefulWidget {
  final int bookId;
  final String bookName;
  final Color color;

  const ChapterScreen({
    super.key,
    required this.bookId,
    required this.bookName,
    required this.color,
  });

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  List<int> chapters = [];

  @override
  void initState() {
    super.initState();
    loadChapters();
  }

  Future<void> loadChapters() async {
    final data = await BibleDatabase.getChapters(widget.bookId);
    setState(() => chapters = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
        backgroundColor: widget.color,
      ),
      body: chapters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 12, // space between cards horizontally
            runSpacing: 12, // space between lines
            children: chapters.map((chapter) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VerseScreen(
                        bookId: widget.bookId,
                        bookName: widget.bookName,
                        chapter: chapter,
                        color: widget.color,
                      ),
                    ),
                  );
                },
                child: Card(
                  color: widget.color.withOpacity(0.8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    child: Text(
                      "$chapter",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
