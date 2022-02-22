import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime time;

  OrderItem(
      {required this.amount,
      required this.id,
      required this.products,
      required this.time});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            amount: total,
            id: DateTime.now().toString(),
            products: cartProducts,
            time: DateTime.now()));
    notifyListeners();
  }

  removeLastOrder() {
    _orders.removeAt(0);
    notifyListeners();
  }
}
