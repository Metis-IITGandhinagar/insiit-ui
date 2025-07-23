// lib/provider/cart_provider.dart

import 'package:flutter/material.dart';
import 'package:insiit/database/db_helper.dart';
import 'package:insiit/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter = 0;
  double _totalPrice = 0.0;
  late Future<List<Cart>> _cart;

  int get counter => _counter;
  double get totalPrice => _totalPrice;
  Future<List<Cart>> get cart => _cart;

  CartProvider() {
    _cart = db.getCartList();
    _loadCartDataFromDb();
  }

  void _loadCartDataFromDb() async {
    List<Cart> cartList = await db.getCartList();
    _updateCartState(cartList);
  }

  // method to update the state from a list of cart items
  void _updateCartState(List<Cart> cartList) {
    _counter = 0;
    _totalPrice = 0.0;
    for (var item in cartList) {
      _counter += item.quantity!;
      _totalPrice += item.itemPrice!;
    }
    _cart = Future.value(cartList); 
    notifyListeners();
  }

  // refresh the cart state
  Future<void> refreshCart() async {
    _loadCartDataFromDb();
  }
  
  // Method to add an item (handles both new items and existing item quantity increase)
  Future<void> add(Cart newCartItem) async {
    List<Cart> currentCart = await db.getCartList();
    
    var existingItemIndex = currentCart.indexWhere((item) => item.itemId == newCartItem.itemId);

    if (existingItemIndex != -1) {
      Cart existingItem = currentCart[existingItemIndex];
      existingItem.quantity = (existingItem.quantity ?? 0) + 1;
      existingItem.itemPrice = (existingItem.unitPrice ?? 0) * (existingItem.quantity ?? 0);
      await db.updateQuantity(existingItem);
    } else {
      await db.insert(newCartItem);
    }
    
    await refreshCart();
  }

  Future<void> remove(Cart itemToRemove) async {
     List<Cart> currentCart = await db.getCartList();
     var existingItemIndex = currentCart.indexWhere((item) => item.itemId == itemToRemove.itemId);

     if (existingItemIndex != -1) {
       Cart existingItem = currentCart[existingItemIndex];
       if (existingItem.quantity! > 1) {
          existingItem.quantity = existingItem.quantity! - 1;
          existingItem.itemPrice = (existingItem.unitPrice ?? 0) * (existingItem.quantity ?? 0);
          await db.updateQuantity(existingItem);
       } else {
          await db.deleteItem(existingItem.id!);
       }
     }
     await refreshCart();
  }
  
  Future<void> delete(int id) async {
    await db.deleteItem(id);
    await refreshCart();
  }

  Future<void> clear() async {
    await db.clearCart();
    await refreshCart();
  }
}
