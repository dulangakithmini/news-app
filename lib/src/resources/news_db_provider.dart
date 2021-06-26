/// Allows working with device's file system
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item_model.dart';

class NewsDbProvider {
  /// Database type is from the sqflite package
  /// This instance variable refers the connection to the actual database in the device
  Database db;

  init() async {
    /// Directory from dart:io package and getApplicationDocumentsDirectory from path_provider.
    /// Returns a reference to a directory in the mobile device where different files can be stored.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    /// From path package
    /// Join the path of the Directory reference with items.db
    final path = join(documentsDirectory.path, "items.db");

    /// Create the database and assign it to reference variable - db
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        /// Can send a arbitrary snippet of SQL with execute
        newDb.execute("""
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            deleted INTEGER,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            dead INTEGER,
            parent INTEGER,
            kids BLOB,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )        
        """);
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    /// Fetch items from the DB
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    /// If there are any records with the given id
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  /// Take an ItemModel and insert to the DB
  addItem(ItemModel item) {
    return db.insert("Items", item.toMapForDb());
  }
}
