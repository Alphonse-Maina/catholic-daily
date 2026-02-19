import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            SizedBox(height: 20),
            Icon(Icons.church, size: 80),
            SizedBox(height: 20),
            Text(
              "Catholic Daily",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "A spiritual companion app providing prayers, readings, saints, and rosary guidance.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text("Version 1.0.0"),
            Spacer(),
            Text("Made with faith "),
          ],
        ),
      ),
    );
  }
}
