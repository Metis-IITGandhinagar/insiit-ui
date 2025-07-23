import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import '../model/cart_model.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cart.db');

    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        itemId TEXT UNIQUE, 
        itemName TEXT,
        unitPrice REAL,
        itemPrice REAL,
        quantity INTEGER,
        outletID TEXT,
        outletName TEXT
      )
    ''');
  }


  // insert method
  Future<Cart> insert(Cart cart) async {
    var dbClient = await db;
    await dbClient!.insert('Cart', cart.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return cart;
  }

  // getCartList method
  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('Cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  // delete method for removing a specific item by its database row id.
  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('Cart', where: 'id = ?', whereArgs: [id]);
  }


  /// for the '+' and '-' buttons in the cart.
  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await db;
    return await dbClient!.update(
      'Cart',
      cart.toMap(),
      where: 'itemId = ?', 
      whereArgs: [cart.itemId],
    );
  }

  /// delete all items from the cart.
  Future<int> clearCart() async {
    var dbClient = await db;
    return await dbClient!.delete('Cart'); 
  }
}
