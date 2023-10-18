import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import '../widgets/gsheet.dart';

class MessDatabase {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, "mess_menu.db"),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE menu (dayName TEXT PRIMARY KEY, breakfast TEXT, lunch TEXT, snacks TEXT, dinner TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await MessDatabase.database();
    // print(db);
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object?>>> getData(String table) async {
    final db = await MessDatabase.database();
    return db.query(table);
  }
}

initializeMessDb() async {
  // print("I am");
  final List<String> weekDays = [
    // Intl packages uses monday as starting index.
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  final mealNameList = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  Map<String, Object> mappings = {};

  for (var i in weekDays) {
    // print(i);
    mappings.addEntries({"dayName": i}.entries);
    for (var j in mealNameList) {
      // print(j);
      List<String> messMenu =
          await UserSheetsApi.getMessMenu(weekDays.indexOf(i) + 1, j);
      var joined = messMenu.join("_");
      mappings.addEntries({j: joined}.entries);
      // print(joined);
    }
    // print(mappings);
    MessDatabase.insert("menu", mappings);
    await MessDatabase.database();
  }
}
