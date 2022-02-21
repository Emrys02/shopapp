import 'package:flutter/material.dart';

import '../widget/nav_menu.dart';
import '../widget/products_grid.dart';

class ProductsPage extends StatelessWidget {
  static const route = 'productpage';
  @override
  Widget build(BuildContext context) {
    var showFavourites = ModalRoute.of(context)?.settings.arguments;
    ModalRoute.of(context)!.settings.arguments == null
        ? showFavourites = false
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping App"),
        actions: [NavMenu()],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ProductsGrid(showFavourites as bool),
    );
  }
}
