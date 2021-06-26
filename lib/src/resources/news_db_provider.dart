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
    /// Directory from dart:io package and getApplicationDocumentsDirectory from path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    /// From path package
    final path = join(documentsDirectory.path, "items.db");
  }
}
