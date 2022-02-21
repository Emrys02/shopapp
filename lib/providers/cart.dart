import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final double quantity;
  final double price;

  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void addItem(String id, double price, String title) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (existingCartItems) => CartItem(
              id: existingCartItems.id,
              price: existingCartItems.price,
              quantity: existingCartItems.quantity + 1,
              title: existingCartItems.title));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              price: price,
              quantity: 1,
              title: title));
    }
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
}
