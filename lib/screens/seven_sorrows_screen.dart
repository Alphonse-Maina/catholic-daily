import 'dart:convert';
import 'package:catholic_daily/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/seven_sorrows.dart';

class SevenSorrowsScreen extends StatefulWidget {
  const SevenSorrowsScreen({super.key});

  @override
  State<SevenSorrowsScreen> createState() => _SevenSorrowsScreenState();
}

class _SevenSorrowsScreenState extends State<SevenSorrowsScreen> {
  SevenSorrows? data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final String jsonString =
    await rootBundle.loadString('lib/data/seven_sorrows.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    setState(() {
      data = SevenSorrows.fromJson(jsonMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: Text(data!.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// HOW TO PRAY
          const Text(
            "How to Pray",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          ...data!.howToPray.map(
                (step) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(step),
            ),
          ),

          const SizedBox(height: 24),

          /// SORROWS
          const Text(
            "The Seven Sorrows",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          ...data!.sorrows.map(
                (sorrow) => ExpansionTile(
              title: Text(
                sorrow.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(sorrow.scripture),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    sorrow.meditation,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// CLOSING PRAYER
          const Text(
            "Closing Prayer",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Text(
            data!.closingPrayer,
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}