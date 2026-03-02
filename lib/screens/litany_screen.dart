import 'dart:convert';
import 'package:catholic_daily/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/litany_model.dart';

class LitanyScreen extends StatefulWidget {
  final String assetPath;

  const LitanyScreen({super.key, required this.assetPath});

  @override
  State<LitanyScreen> createState() => _LitanyScreenState();
}

class _LitanyScreenState extends State<LitanyScreen> {
  Litany? litany;

  @override
  void initState() {
    super.initState();
    loadLitany();
  }

  Future<void> loadLitany() async {
    final jsonString = await rootBundle.loadString(widget.assetPath);
    final jsonMap = json.decode(jsonString);
    setState(() {
      litany = Litany.fromJson(jsonMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (litany == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: Text(litany!.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (litany!.subtitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  litany!.subtitle!,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            Text(
              litany!.body,
              textAlign: TextAlign.left,
              style: const TextStyle(height: 1.5),
            ),

            const SizedBox(height: 24),

            if (litany!.closingPrayer != null) ...[
              const Text(
                "Let us pray",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                litany!.closingPrayer!,
                textAlign: TextAlign.justify,
              ),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}