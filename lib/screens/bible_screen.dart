import 'package:flutter/material.dart';
import '../services/bible_database.dart';
import 'book_list_screen.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  List<Map<String, dynamic>> books = [];

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    final data = await BibleDatabase.getBooks();
    setState(() => books = data);
  }

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final oldTestament = books.where((b) => b["id"] <= 39).toList();
    final newTestament = books.where((b) => b["id"] > 39).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Holy Bible")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTile("Old Testament", oldTestament),
          _sectionTile("New Testament", newTestament),
        ],
      ),
    );
  }

  Widget _sectionTile(String title, List<Map<String, dynamic>> data) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 20)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookListScreen(title: title, books: data),
            ),
          );
        },
      ),
    );
  }
}
