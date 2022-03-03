import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.description,
      required this.id,
      required this.imageUrl,
      this.isFavourite = false,
      required this.price,
      required this.title});

  Future<void> toggleFavouriteStatus(String id) async {
    try {
      var url = Uri.parse(
          "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/products/$id.json");
      await http.patch(url, body: json.encode({"isFavourite": !isFavourite}));
    } finally {
      isFavourite = !isFavourite;
      notifyListeners();
    }
  }
}
