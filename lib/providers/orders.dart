import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:http/http.dart' as http;

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
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  addOrder(List<CartItem> cartProducts, double total, String id, String authToken, String userId) async {
    try {
      var url = Uri.parse(
          "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
      var time = DateTime.now();
      var body = cartProducts
          .map((e) => {
                "title": e.title,
                "price": e.price,
                "quantity": e.quantity,
                "id": e.id
              })
          .toList();
      var response = await http.post(url,
          body: json.encode({
            "id": id,
            "amount": total,
            "products": body,
            "time": time.toIso8601String(),
          }));
      _orders.insert(
          0,
          OrderItem(
              amount: total,
              id: json.decode(response.body)["name"],
              products: cartProducts,
              time: DateTime.now()));
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    } finally {}
  }

  removeLastOrder() {
    _orders.removeAt(0);
    notifyListeners();
  }

  Future<void> retrieveOrders(String authToken, String userId) async {
    var url = Uri.parse(
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
    try {
      final out = await http.get(url);
      final data = json.decode(out.body);
      _orders.clear();
      data.forEach((key, value) {
        var ask = OrderItem(
          amount: value["amount"],
          id: key,
          products: (value["products"] as List).map((e) {
            var item = CartItem(
                id: e["id"],
                price: e["price"],
                quantity: e["quantity"],
                title: e["title"]);
            print(item.id);
            print(item.price);
            print(item.quantity);
            print(item.title);
            return item;
          }).toList(),
          time: DateTime.parse(value["time"]),
        );
        print(ask.products);
        _orders.insert(0,ask);
      });
    } catch (error) {
      print(error);
    } finally {}
  }
}
