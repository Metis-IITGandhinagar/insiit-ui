import 'package:flutter/material.dart';
import 'package:insiit/database/db_helper.dart';
import 'package:insiit/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter = 0;
  int get cartCounter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getCart() async {
    _cart = db.getCartList();
    return _cart;
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    debugPrint("Counter in removeCounter: $_counter");
    if (_counter > 0) {
      _counter--;
      _setPrefItems();
      debugPrint("Counter in setpref: $_counter");
    }
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double price) {
    _totalPrice += price;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double price) {
    if (_totalPrice > 0) {
      _totalPrice -= price;
      _setPrefItems();
    }
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void clearCart() {
    _counter = 0;
    _totalPrice = 0.0;
    _setPrefItems();
    notifyListeners();
  }
}
