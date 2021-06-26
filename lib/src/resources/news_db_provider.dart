/// Allows working with device's file system
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
      onCreate: (Database newDb, int version) {},
    );
  }
}
