import 'package:flutter/material.dart';
import 'chapter_screen.dart';

class BookListScreen extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> books;

  const BookListScreen({super.key, required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, i) {
          final book = books[i];

          return ListTile(
            title: Text(book["name"]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChapterScreen(
                    bookId: book["id"],
                    bookName: book["name"],
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
