import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class BookmarkService {
  static const key = "bookmarks";

  static Future<List> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    return data == null ? [] : jsonDecode(data);
  }

  static Future<void> add(Map verse) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await getBookmarks();
    list.add(verse);
    prefs.setString(key, jsonEncode(list));
  }
}
