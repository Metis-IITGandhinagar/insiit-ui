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
        productId TEXT,
        productName TEXT,
        unitPrice REAL,
        productPrice REAL,
        quantity INTEGER,
        outletID TEXT,
        outletName TEXT
      )
    ''');
  }

  Future<Cart> insert(Cart cart) async {
    print(cart.toMap());
    var dbClient = await db;
    await dbClient!.insert('Cart', cart.toMap());
    return cart;
  }

  // Future<List<Cart>> getCart() async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient!.query('Cart', columns: [
  //     'id',
  //     'productId',
  //     'productName',
  //     'unitPrice',
  //     'productPrice',
  //     'quantity',
  //     'outletID',
  //     'outletName'
  //   ]);
  //   List<Cart> cart = [];
  //   if (maps.length > 0) {
  //     for (int i = 0; i < maps.length; i++) {
  //       cart.add(Cart.fromMap(maps[i]));
  //     }
  //   }
  //   return cart;
  // }
  Future<List<Cart>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('Cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('Cart', where: 'id = ?', whereArgs: [id]);
  }
}
