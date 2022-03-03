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
  void initState() {
    Future.delayed(Duration.zero, () async {
      try {
        setState(() {
          isLoading = true;
        });
        await Provider.of<ProductData>(context, listen: false)
            .retrieveProduct();
      } catch (error) {
        print(error);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(showFavourites as bool),
    );
  }
}
