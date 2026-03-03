import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  final String mpesaNumber = "0704668123";

  Future<void> openMpesa() async {
    final uri = Uri.parse("tel:*334#");
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> copyNumber(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: mpesaNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Number copied ✔"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> openPaypal() async {
    final uri = Uri.parse("https://paypal.me/alphonsemaina");

    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      // fallback: show an error
      print("Could not launch PayPal link");
    }
  }

  final Color themeColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackground,
        title: const Text("Donate"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeColor.withOpacity(.12), themeColor.withOpacity(.12)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(35)),
            ),
            child: Column(
              children: [
                const Icon(Icons.favorite, color: Colors.red, size: 40),
                const SizedBox(height: 10),
                const Text(
                  "Support Development",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Help keep this Catholic app growing 🙏",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // M-PESA CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    const Icon(Icons.phone_android, size: 40, color: Colors.green),
                    const SizedBox(height: 15),
                    const Text(
                      "Donate via M-Pesa",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SelectableText(
                      mpesaNumber,
                      style: const TextStyle(fontSize: 22, letterSpacing: 2, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.copy),
                            label: const Text("Copy"),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: () => copyNumber(context),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.send),
                            label: const Text("Open M-Pesa"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            onPressed: openMpesa,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),

          // PAYPAL CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: const Icon(Icons.public, color: Colors.blue),
                title: const Text("Donate via PayPal"),
                subtitle: const Text("For international support"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: openPaypal,
              ),
            ),
          ),

          const Spacer(),

          // FOOTER
          const Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              "Thank you for supporting faith technology ❤️",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}