import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../notifications/notification_service.dart';
import '../services/settings_service.dart';
import 'about_screen.dart';
import 'donate_screen.dart';
import 'package:mailto/mailto.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  final Color themeColor = Colors.deepPurple;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  void loadSettings() async {
    notifications = await SettingsService.notificationsEnabled();
    setState(() {});
  }

  void toggleNotifications(bool val) async {
    print("Toggle pressed: $val");
    await SettingsService.setNotifications(val);

    if (val) {
      print("Scheduling notification...");
      final testTime = DateTime.now().add(const Duration(minutes: 1));
      await NotificationService.scheduleNextDailyVerse(
        // hour: 8,
        // minute: 0,
        hour: testTime.hour,
        minute: testTime.minute,
      );
      print("Schedule function finished.");
    } else {
      print("Cancelling notification...");
      await NotificationService.cancelDailyVerse();
    }

    setState(() => notifications = val);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor.withOpacity(.12),
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: themeColor,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: SwitchListTile(
              title: const Text(
                "Daily Notifications",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Saint, readings, reflections"),
              value: notifications,
              onChanged: toggleNotifications,
              activeColor: themeColor,
            ),
          ),

          const SizedBox(height: 20),


          _settingsTile(
            icon: Icons.info_outline,
            title: "About App",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()));
            },
          ),

          const SizedBox(height: 12),


          _settingsTile(
            icon: Icons.favorite_outline,
            title: "Support / Donate",
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const DonationScreen()));
            },
          ),

          const SizedBox(height: 12),

          _settingsTile(
            icon: Icons.email_outlined,
            title: "Contact / Feedback",
            onTap: () async {
              final mailtoLink = Mailto(
                  to: ['rexalphonso@gmail.com'],
                  subject: 'Catholic Daily App Feedback',
                  body: 'Hello Alphonse,\n\nI would like to suggest...'
              );

              await launchUrl(Uri.parse(mailtoLink.toString()));
            },
          ),
        ],
      ),
    );
  }

  Widget _settingsTile(
      {required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: themeColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios, color: themeColor, size: 18),
        onTap: onTap,
      ),
    );
  }
}