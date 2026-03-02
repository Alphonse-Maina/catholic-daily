import 'package:flutter/material.dart';
import '../constants/colors.dart';
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
    final Color bgColor = AppColors.appBarBackground;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: const Text("Holy Bible"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _bibleSectionCard("Old Testament", oldTestament, bgColor),
          _bibleSectionCard("New Testament", newTestament, bgColor),
        ],
      ),
    );
  }
  Widget _bibleSectionCard(
      String title, List<Map<String, dynamic>> books, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookListScreen(
                title: title,
                books: books,
                bgColor: color,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.15),
              ),
              child: Icon(
                Icons.book,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
