import 'package:flutter/material.dart';
import '../data/full_prayers.dart';
import '../data/prayers.dart';
import '../models/mystery.dart';

class PrayerScreen extends StatefulWidget {
  final List<Mystery> mysteries; // all mysteries for today
  final Color themeColor;
  final bool reset;

  const PrayerScreen({
    super.key,
    required this.mysteries,
    required this.themeColor,
    this.reset = false,
  });

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  int currentMysteryIndex = 0;
  int currentPrayerIndex = 0;

  Mystery get currentMystery => widget.mysteries[currentMysteryIndex];

  void nextPrayer() {
    setState(() {
      if (currentPrayerIndex < prayers.length - 1) {
        currentPrayerIndex++;
      } else {
        // Completed this mystery, go to next
        currentPrayerIndex = 0;
        if (currentMysteryIndex < widget.mysteries.length - 1) {
          currentMysteryIndex++;
        } else {
          // Rosary complete
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Rosary Complete"),
              content: const Text("You have finished today's Rosary."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentMystery.title),
        backgroundColor: widget.themeColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              setState(() {
                currentPrayerIndex = 0;
              });
            },
            tooltip: "Reset Rosary",
          )
        ],
      ),
      body: Column(
        children: [
          // Image
          Image.asset(
            currentMystery.imageAsset,
            width: double.infinity,
            height: 500,
            fit: BoxFit.cover,
          ),

          // Mystery description
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  currentMystery.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(currentMystery.shortDescription,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  currentMystery.bibleReference,
                  style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: widget.themeColor.withOpacity(0.8)),
                ),
              ],
            ),
          ),

          const Divider(),

          // Full prayers list with highlight
          Expanded(
            child: ListView.builder(
              itemCount: decadePrayers.length,
              itemBuilder: (context, index) {
                final line = decadePrayers[index];
                final isCurrent = index == currentPrayerIndex;

                Color color;
                switch (line.type) {
                  case PrayerType.ourFather:
                    color = Colors.red;
                    break;
                  case PrayerType.hailMary:
                    color = Colors.blue;
                    break;
                  case PrayerType.gloryBe:
                  case PrayerType.fatima:
                    color = Colors.green;
                    break;
                }

                return ListTile(
                  title: Text(
                  line.text,
                    style: TextStyle(
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      color: isCurrent ? color : Colors.black87,
                    ),
                  ),
                  onTap: () => setState(() => currentPrayerIndex = index),
                );
              },
            ),
          ),


          // Tap button to advance prayer
          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: nextPrayer,
              style: ElevatedButton.styleFrom(
                  backgroundColor: widget.themeColor,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 16)),
              child: Text(
                currentPrayerIndex < 10
                    ? "Hail Mary ${currentPrayerIndex + 1}"
                    : prayers[currentPrayerIndex],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
