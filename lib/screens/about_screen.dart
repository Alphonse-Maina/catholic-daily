import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.church, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              "Catholic Daily",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "A spiritual companion app providing daily prayers, readings, saints, and rosary guidance.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text("Version 1.0.0"),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),

            // More About / Mission
            const Text(
              "Mission: To bring Catholic spirituality to your fingertips and help you grow closer to Christ daily.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "Features: Daily Mass readings, Saint of the day, Catholic prayers, Rosary guidance, and Bible navigation.",
              textAlign: TextAlign.center,
            ),
            const Spacer(),

            // Powered by VexaRyn
            Column(
              children: [
                Image.asset(
                  'assets/app/vexaryn_logo.png',
                  height: 50,
                ),
                const SizedBox(height: 6),
                const Text(
                  "Powered by VexaRyn",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
