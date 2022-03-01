import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products_data.dart';
import 'package:shopapp/screens/add_new_product_page.dart';
import 'package:shopapp/widget/nav_menu.dart';
import 'package:shopapp/widget/user_product_items.dart';

class UserProducts extends StatelessWidget {
  static const route = "UserProducts";
  @override
  Widget build(BuildContext context) {
    ProductData provider = Provider.of<ProductData>(context);
    List<Product> products = provider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddNewProductPage.route),
            icon: const Icon(Icons.add),
          ),
          NavMenu()
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => UserProductItems(products[index], provider.removeProduct),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_rounded),
          onPressed: () =>
              Navigator.of(context).pushNamed(AddNewProductPage.route),),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
