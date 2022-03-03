import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/global_variables.dart';
import '../screens/product_details.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final individualItem = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return Consumer(
      builder: (BuildContext context, value, Widget? child) => GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetails.route, arguments: individualItem);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: GridTile(
            child: FadeInImage.assetNetwork(
                image: individualItem.imageUrl,
                placeholder: Global.loadingImage,
                fit: BoxFit.cover,
                fadeInCurve: Curves.easeInToLinear,
                fadeOutCurve: Curves.linearToEaseOut),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(
                individualItem.title,
                textAlign: TextAlign.center,
              ),
              leading: IconButton(
                onPressed: () async {
                  try {
                    await individualItem
                        .toggleFavouriteStatus(individualItem.id.toString());
                  } finally {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        content: const Text("Successfully Marked As Favourite"),
                        action: SnackBarAction(
                          label: "Undo",
                          onPressed: () => individualItem.toggleFavouriteStatus(
                              individualItem.id.toString()),
                        ),
                      ),
                    );
                  }
                },
                icon: Icon(
                    individualItem.isFavourite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: Theme.of(context).accentColor),
              ),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart_rounded,
                    color: Theme.of(context).accentColor),
                onPressed: () {
                  cart.addItem(individualItem.id!, individualItem.price,
                      individualItem.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3),
                      content: const Text("Successfully Added To Cart!"),
                      action: SnackBarAction(
                        label: "Undo",
                        onPressed: () => cart.removeItem(individualItem.id!),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
