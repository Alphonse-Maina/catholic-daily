import 'package:flutter/material.dart';
import 'chapter_screen.dart';

class BookListScreen extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> books;
  final Color bgColor;

  const BookListScreen({super.key, required this.title, required this.books, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: bgColor,),
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
                    color: bgColor,
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
