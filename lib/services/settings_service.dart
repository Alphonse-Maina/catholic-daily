import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _notifKey = "notifications_enabled";

  static Future<bool> notificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notifKey) ?? true;
  }

  static Future<void> setNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notifKey, value);
  }
}
