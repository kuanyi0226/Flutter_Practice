import 'package:flutter/foundation.dart'; //for debug_print
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  //Create Table: table name is "items"
  static Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  //Create or Open Database
  static Future<Database> db() async {
    return openDatabase(
      'dbtest.db',
      version: 1,
      onCreate: (Database database, int version) async {
        print('creating a table');
        await createTable(database);
      },
    );
  }

  //CRUD
  //C: Create
  static Future<int> createItem(String title, String description) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'description': description};
    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  //R: Read ALL
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: 'id');
  }

  //R: Read Certain
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  //U: Update
  static Future<int> updateItem(
      int id, String title, String? description) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now().toString(),
    };
    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  //D: Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something got Wrong while deleting item: $err');
    }
  }
}
