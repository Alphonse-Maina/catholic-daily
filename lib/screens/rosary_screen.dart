import 'package:catholic_daily/constants/colors.dart';
import 'package:catholic_daily/screens/pray_with_me.dart';
import 'package:flutter/material.dart';
import '../data/rosary_loader.dart';
import '../models/liturgical_day.dart';
import '../models/mystery.dart';
import 'list_mysteries_screen.dart';

class RosaryScreen extends StatefulWidget {
  const RosaryScreen({super.key});

  @override
  State<RosaryScreen> createState() => _RosaryScreenState();
}

class _RosaryScreenState extends State<RosaryScreen> {
  LiturgicalDay? today;
  Color themeColor = AppColors.appBarBackground;
  Map <String, List<Mystery>> allMysteries = {};

  @override
  void initState() {
    super.initState();
    _loadMysteries();
  }

  Future<void> _loadMysteries() async {
    final mysteriesMap = await RosaryLoader.loadAllMysteries();

    setState(() {
      allMysteries = mysteriesMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("The Mysteries of the Rosary"),
        backgroundColor: themeColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: allMysteries.keys.map((key) {
                final title = "The ${key[0].toUpperCase()}${key.substring(1)} Mysteries";

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListMysteriesScreen(
                          title: key,
                          allMysteries: allMysteries[key]!,
                          color: themeColor,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: themeColor.withOpacity(.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: themeColor.withOpacity(.15),
                          ),
                          child: Icon(
                            Icons.book,
                            color: themeColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Tap to meditate and pray",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: themeColor,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrayWithMe()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor.computeLuminance()>0.5? Colors.black : Colors.white ,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.self_improvement, size: 20),
              label: const Text(
                "Pray Today's Rosary",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
