import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/accounts.dart';
import '../providers/auth.dart';
import '../providers/orders.dart';
import '../providers/product.dart';
import '../widget/nav_menu.dart';

import '../providers/cart.dart';

class ProductDetails extends StatelessWidget {
  static const route = 'productdetails';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Orders>(context);
    var deviceProperties = MediaQuery.of(context);
    final auth = Provider.of<Auth>(context);
    Product _selectedItem =
        ModalRoute.of(context)?.settings.arguments as Product;

    AppBar appbar = AppBar(
      title: Text(_selectedItem.title),
      actions: [NavMenu()],
    );
    return Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FadeInImage.assetNetwork(
                      placeholder: 'images/loading.gif',
                      image: _selectedItem.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity),
                ),
              ),
              SizedBox(
                height: (deviceProperties.size.height -
                        appbar.preferredSize.height -
                        deviceProperties.padding.top) *
                    0.05,
              ),
              Card(
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_shopping_cart_rounded),
                      label: const Text("Add To Cart"),
                      onPressed: () {
                        cart.addItem(_selectedItem.id, _selectedItem.price,
                            _selectedItem.title);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Successfully Added To Cart"),
                          action: SnackBarAction(
                              label: "Undo",
                              onPressed: () =>
                                  cart.removeItem(_selectedItem.id)),
                        ));
                      },
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text("Buy Now"),
                      onPressed: () {
                        order.addOrder(
                            [
                              CartItem(
                                  id: _selectedItem.id,
                                  price: _selectedItem.price,
                                  quantity: 1,
                                  title: _selectedItem.title)
                            ],
                            _selectedItem.price,
                            Provider.of<AcctDetails>(context, listen: false)
                                .activeUser!
                                .id, auth.authtoken, auth.userID);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Successfully CheckedOut Item"),
                          action: SnackBarAction(
                              label: "Undo",
                              onPressed: () => order.removeLastOrder()),
                        ));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
