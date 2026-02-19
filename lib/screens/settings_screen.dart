import 'package:flutter/material.dart';
import '../services/settings_service.dart';
import 'about_screen.dart';
import 'donate_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;

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
    await SettingsService.setNotifications(val);
    setState(() => notifications = val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [

          /// 🔔 Notifications
          SwitchListTile(
            title: const Text("Daily Notifications"),
            subtitle: const Text("Saint, readings, reflections"),
            value: notifications,
            onChanged: toggleNotifications,
          ),

          const Divider(),

          /// ℹ️ About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About App"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),

          /// ❤️ Donate
          ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text("Support / Donate"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DonationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
