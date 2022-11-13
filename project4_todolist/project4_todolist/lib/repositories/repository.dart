import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import './database_connection.dart';

class Repository {
  DatabaseConnection? _databaseConnection;

  //Constructor: initialize databaseConnection
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection!.setDatabase();
    return _database;
  }

  //Insert data to the table
  insertData(table, data) async {
    var connection = await database;
    return await connection!
        .insert(table, data); //return an the id(int) last inserted
  }

  //Read data from the table
  readData(table) async {
    var connection = await database;
    return await connection!.query(table);
  }

  //Read data by ID from the table
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection!.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //Update data to the table
  updateData(table, data) async {
    var connection = await database;
    return await connection!
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete data from the table
  deleteData(String table, itemId) async {
    var connection = await database;
    return await connection!.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }
}
