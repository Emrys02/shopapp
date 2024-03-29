import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  double quantity = 1.0;
  final double price;

  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
  });

  CartItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        quantity = json['quantity'],
        price = json['price'];

  static Map<String, dynamic> toJson(CartItem item) => {
        "id": item.id,
        "title": item.title,
        'price': item.price,
        'quantity': item.quantity
      };
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

  void removeItem(String itemId) {
    if (_items[itemId]!.quantity > 1) {
      _items.update(
          itemId,
          (value) => CartItem(
              id: value.id,
              price: value.price,
              quantity: value.quantity - 1,
              title: value.title));
    } else if (_items[itemId]!.quantity == 1) {
      _items.remove(itemId);
    }
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
