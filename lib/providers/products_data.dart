import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class ProductData with ChangeNotifier {
  final List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

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
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products.json");
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
      print(error);
      rethrow;
    } finally {
      _items.add(newItem);
      notifyListeners();
    }
  }

  void removeProduct(Product item) {
    var url = Uri.parse(
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products/${item.id}.json");
    try {
      print(item.id);
      http.delete(url);
    } catch (error) {
      print(error);
      rethrow;
    } finally {
      _items.removeWhere((element) =>
          element.title == item.title && element.price == item.price);
      notifyListeners();
    }
  }

  Future<void> editProduct(Product existingItem, Product newItem) async {
    var url = Uri.parse(
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products/${existingItem.id}.json");
    try {
      await http.patch(url,
          body: json.encode({
            'title': newItem.title,
            'description': newItem.description,
            'imageUrl': newItem.imageUrl,
            'price': newItem.price
          }));
    } catch (error) {
      print(error);
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
        "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products.json");
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
          isFavourite: value['isFavourite'],
        ));
      });
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
