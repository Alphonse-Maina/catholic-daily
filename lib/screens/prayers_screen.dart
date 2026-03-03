import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../constants/colors.dart';

class PrayersPage extends StatefulWidget {
  const PrayersPage({Key? key}) : super(key: key);

  @override
  State<PrayersPage> createState() => _PrayersPageState();
}

class _PrayersPageState extends State<PrayersPage> {
  Map<String, dynamic>? prayersData;
  bool loading = true;

  final Color themeColor = AppColors.appBarBackground;

  @override
  void initState() {
    super.initState();
    loadPrayers();
  }

  Future<void> loadPrayers() async {
    final String jsonString =
    await rootBundle.loadString('lib/data/prayers.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      prayersData = jsonData;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: const Text('Catholic Prayers'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: prayersData!['prayers'].length,
        itemBuilder: (context, index) {
          final category = prayersData!['prayers'][index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: themeColor.withOpacity(.15),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: themeColor.withOpacity(.15)),
            ),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              collapsedBackgroundColor: Colors.white,
              iconColor: themeColor,
              collapsedIconColor: themeColor,
              title: Text(
                category['category'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              children: List.generate(category['items'].length, (i) {
                final prayer = category['items'][i];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PrayerDetailPage(prayer: prayer),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            prayer['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16, color: themeColor),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
class PrayerDetailPage extends StatelessWidget {
  final Map<String, dynamic> prayer;
  const PrayerDetailPage({Key? key, required this.prayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color themeColor = Colors.deepPurple;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: Text(prayer['title']),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            prayer['text'],
            style: const TextStyle(
              fontSize: 18,
              height: 1.6,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
