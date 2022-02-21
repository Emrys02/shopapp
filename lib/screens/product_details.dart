import 'package:flutter/material.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/widget/nav_menu.dart';

class ProductDetails extends StatelessWidget {
  static const route = 'productdetails';

  @override
  Widget build(BuildContext context) {
    Product _selectedItem =
        ModalRoute.of(context)?.settings.arguments as Product;

    AppBar appbar = AppBar(
      title: Text(_selectedItem.title),
      actions: [NavMenu()],
    );
    return Scaffold(
        appBar: appbar,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: FadeInImage.assetNetwork(
                  placeholder: 'images/loading.gif',
                  image: _selectedItem.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.05,
            ),
            Text("\$${_selectedItem.price}"),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.05,
            ),
            Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.1,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                child: Text(
                  _selectedItem.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ))
          ],
        ));
  }
}
