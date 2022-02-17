import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';

class ProductDetails extends StatelessWidget {
  static const route = 'productdetails';

  @override
  Widget build(BuildContext context) {
    Product _selectedItem =
        ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedItem.title),
      ),
    );
  }
}
