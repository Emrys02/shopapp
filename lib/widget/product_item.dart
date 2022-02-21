import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_details.dart';

class ProductItem extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    final individualItem = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return Consumer(
        builder: (BuildContext context, value, Widget? child) =>
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ProductDetails.route, arguments: individualItem);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: GridTile(
                  child: FadeInImage.assetNetwork(
                      image: individualItem.imageUrl,
                      placeholder: 'images/loading.gif',
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
                      onPressed: () => individualItem.toggleFavouriteStatus(),
                      icon: Icon(
                          individualItem.isFavourite
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          color: Theme.of(context).accentColor),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add_shopping_cart_rounded,
                          color: Theme.of(context).accentColor),
                      onPressed: ()=>cart.addItem(individualItem.id, individualItem.price, individualItem.title),
                    ),
                  ),
                ),
              ),
            ));
  }
}
