import 'package:flutter/material.dart';

class CartState extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems;
  CartState();

  void setCartItems(List val) {
    _cartItems = val;
    notifyListeners();
  }

  List<Map<String, dynamic>> get cartItems => _cartItems;
}
