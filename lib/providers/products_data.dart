import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductData with ChangeNotifier {
  final String authToken;

  ProductData(this.authToken);

  final List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  String get itemsCount {
    return _items.length.toString();
  }

  List<Product> get favitems {
    return [...items.where((element) => element.isFavourite)];
  }

  Future<void> addProduct(Product newItem) async {
    var url = Uri.parse(
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products.json?auth=$authToken");
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': newItem.title,
            'description': newItem.description,
            'imageUrl': newItem.imageUrl,
            'price': newItem.price,
            'isFavourite': newItem.isFavourite,
          },
        ),
      );
      newItem.id = json.decode(response.body)["name"];
    } catch (error) {
      rethrow;
    } finally {
      _items.add(newItem);
      notifyListeners();
    }
  }

  void removeProduct(Product item) {
    var url = Uri.parse(
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products/${item.id}.json?auth=$authToken");
    try {
      http.delete(url);
    } catch (error) {
      rethrow;
    } finally {
      _items.removeWhere((element) =>
          element.title == item.title && element.price == item.price);
      notifyListeners();
    }
  }

  Future<void> editProduct(Product existingItem, Product newItem) async {
    var url = Uri.parse(
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products/${existingItem.id}.json?auth=$authToken");
    try {
      await http.patch(url,
          body: json.encode({
            'title': newItem.title,
            'description': newItem.description,
            'imageUrl': newItem.imageUrl,
            'price': newItem.price
          }));
    } catch (error) {
      rethrow;
    } finally {
      var pos = _items.indexWhere((element) =>
          element.title == existingItem.title &&
          element.price == existingItem.price);
      _items.removeAt(pos);
      _items.insert(pos, newItem);
      notifyListeners();
    }
  }

  Future<void> retrieveProduct() async {
    var url = Uri.parse(
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products.json?auth=$authToken");
    try {
      final out = await http.get(url);
      final data = json.decode(out.body);
      _items.clear();
      data.forEach((id, value) {
        _items.add(Product(
          id: id,
          description: value['description'],
          imageUrl: value['imageUrl'],
          price: value['price'],
          title: value['title'],
        ));
      });
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
