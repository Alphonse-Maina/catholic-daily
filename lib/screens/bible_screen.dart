import 'package:flutter/material.dart';
import '../models/liturgical_day.dart';
import '../services/bible_database.dart';
import '../services/liturgical_service.dart';
import 'book_list_screen.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  List<Map<String, dynamic>> books = [];
  LiturgicalDay? today;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    final service = LiturgicalService();
    final now = DateTime.now();

    final lit = service.getDay(now);
    final data = await BibleDatabase.getBooks();
    setState(() => books = data);
    setState(() {
      today = lit;
    });
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
    final Color bgColor = today!.colorValue;

    return Scaffold(
      backgroundColor: bgColor.withOpacity(.12),
      appBar: AppBar(title: const Text("Holy Bible"), backgroundColor: bgColor,),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTile("Old Testament", oldTestament, bgColor),
          _sectionTile("New Testament", newTestament, bgColor),
        ],
      ),
    );
  }

  Widget _sectionTile(String title, List<Map<String, dynamic>> data, color) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 20)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookListScreen(title: title, books: data, bgColor: color),
            ),
          );
        },
      ),
    );
  }
}
