import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/screens/product_details.dart';

class ProductItem extends StatelessWidget {
  final Product individualItem;

  const ProductItem(this.individualItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              onPressed: () {},
              icon: Icon(Icons.favorite_rounded,
                  color: Theme.of(context).accentColor),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart_rounded,
                  color: Theme.of(context).accentColor),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
