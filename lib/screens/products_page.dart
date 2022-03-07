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

bool isLoading = false;

class _ProductsPageState extends State<ProductsPage> {
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
      body: FutureBuilder(
        future:
            Provider.of<ProductData>(context, listen: false).retrieveProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return InkWell(
              onTap: () => Provider.of<ProductData>(context, listen: false)
                  .retrieveProduct(),
              child: const Center(
                child: Text(
                    "something went wrong while retrieving products\n Pull down to refresh"),
              ),
            );
          } else {
            return ProductsGrid(showFavourites as bool);
          }
        },
      ),
    );
  }
}
