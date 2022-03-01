import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_data.dart';
import '../widget/nav_menu.dart';
import '../widget/products_grid.dart';

class ProductsPage extends StatefulWidget {
  static const route = 'productpage';

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

bool restart = true;

class _ProductsPageState extends State<ProductsPage> {
  @override
  void didChangeDependencies() {
    if (restart) {
      Provider.of<ProductData>(context).retrieveProduct();
    }
    restart = false;
    super.didChangeDependencies();
  }

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
