import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
  // Set the path to the database.
  join(await getDatabasesPath(), 'access_database.db'),
  // When the database is first created, create a table to store dogs.
  onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
    return db.execute(
      "CREATE TABLE ble_mac(id INTEGER PRIMARY KEY, mac INTEGER, access_level INTEGER)",
    );
  },
  // Set the version. This executes the onCreate function and provides a
  // path to perform database upgrades and downgrades.
  version: 1,
  );
}
