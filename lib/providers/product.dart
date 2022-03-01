import 'package:flutter/foundation.dart';

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

  void toggleFavouriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
