import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HighlightService {
  static const key = "highlights";

  static Future<List<int>> get() async {
    final p = await SharedPreferences.getInstance();
    final d = p.getString(key);
    return d == null ? [] : List<int>.from(jsonDecode(d));
  }

  static Future toggle(int id) async {
    final p = await SharedPreferences.getInstance();
    final list = await get();

    list.contains(id) ? list.remove(id) : list.add(id);

    p.setString(key, jsonEncode(list));
  }
}
