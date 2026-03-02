import 'dart:convert';
import 'package:catholic_daily/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/station.dart'; // For loading JSON from assets

class WayOfTheCrossScreen extends StatefulWidget {
  const WayOfTheCrossScreen({super.key});

  @override
  State<WayOfTheCrossScreen> createState() => _WayOfTheCrossScreenState();
}

class _WayOfTheCrossScreenState extends State<WayOfTheCrossScreen> {
  List<Station> stations = [];

  @override
  void initState() {
    super.initState();
    loadStations();
  }

  Future<void> loadStations() async {
    final String data = await rootBundle.loadString('lib/data/way_of_the_cross.json');
    final List<dynamic> jsonResult = json.decode(data);
    setState(() {
      stations = jsonResult.map((s) => Station.fromJson(s)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (stations.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
          title: const Text("Way of the Cross"),
          backgroundColor: AppColors.appBarBackground,
      ),
      body: PageView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final s = stations[index];
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 ...[
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          s.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
                Text(s.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                if (s.adoration.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text("ADORATION", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(s.adoration),
                ],
                if (s.scripture.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text("SCRIPTURE", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(s.scripture),
                ],
                if (s.meditation.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text("MEDITATION", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(s.meditation),
                ],
                if (s.prayer.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text("PRAYER", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(s.prayer),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}