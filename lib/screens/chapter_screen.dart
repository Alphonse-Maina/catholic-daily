import 'package:flutter/material.dart';
import '../services/bible_database.dart';
import 'verse_screen.dart';

class ChapterScreen extends StatefulWidget {
  final int bookId;
  final String bookName;
  final color;

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
      appBar: AppBar(title: Text(widget.bookName), backgroundColor: widget.color,),
      body: chapters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, i) {
          final chapter = chapters[i];

          return ListTile(
            title: Text("Chapter $chapter"),
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
          );
        },
      ),
    );
  }
}
