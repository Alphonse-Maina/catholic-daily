import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BibleDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "KJV.db");

    final exists = await databaseExists(path);

    if (!exists) {
      ByteData data = await rootBundle.load("assets/Bible/KJV.db");
      final bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    _db = await openDatabase(path, readOnly: true);
    return _db!;
  }

  static Future<List<Map<String, dynamic>>> getBooks() async {
    final db = await database;
    return await db.query("KJV_books", orderBy: "id");
  }

  static Future<List<int>> getChapters(int bookId) async {
    final db = await database;

    final result = await db.rawQuery(
      "SELECT DISTINCT chapter FROM KJV_verses WHERE book_id = ? ORDER BY chapter",
      [bookId],
    );

    return result.map((e) => e["chapter"] as int).toList();
  }

  static Future<List<Map<String, dynamic>>> getVerses(
      int bookId, int chapter) async {
    final db = await database;

    return await db.query(
      "KJV_verses",
      where: "book_id=? AND chapter=?",
      whereArgs: [bookId, chapter],
      orderBy: "verse",
    );
  }

  static Future<List<Map<String, dynamic>>> search(String query) async {
    final db = await database;

    return await db.rawQuery('''
  SELECT * FROM KJV_verses
  WHERE text LIKE ?
  LIMIT 50
  ''', ["%$query%"]);
  }

}
