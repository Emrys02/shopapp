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

  Future<void> toggleFavouriteStatus(String productId, String authToken, String userId) async {
    try {
      var url = Uri.parse(
          "https://flutter-shopapp-71dfd-default-rtdb.firebaseio.com/favourites/$userId/$productId.json?auth=$authToken");
      await http.put(url, body: json.encode({"isFavourite":!isFavourite}));
    } catch (error) {
      rethrow;
    } finally {
      isFavourite = !isFavourite;
      notifyListeners();
    }
  }
}
