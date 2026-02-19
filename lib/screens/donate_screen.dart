import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  final String mpesaNumber = "0704668123";

  Future<void> openMpesa() async {
    final uri = Uri.parse("tel:*334#");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> copyNumber(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: "0704668123"));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Number copied ✔"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> openPaypal() async {
    final uri = Uri.parse("https://paypal.me/yourname"); // replace later
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(35),
              ),
            ),
            child: const Column(
              children: [
                Icon(Icons.favorite, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "Support Development",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Help keep this Catholic app growing 🙏",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    const Icon(Icons.phone_android,
                        size: 40, color: Colors.green),

                    const SizedBox(height: 15),

                    const Text(
                      "Donate via M-Pesa",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    SelectableText(
                      mpesaNumber,
                      style: const TextStyle(
                        fontSize: 22,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// BUTTONS
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.copy),
                            label: const Text("Copy"),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
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

          /// PAYPAL CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
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

          /// FOOTER
          const Padding(
            padding: EdgeInsets.all(14),
            child: Text(
              "Thank you for supporting faith technology ❤️",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
