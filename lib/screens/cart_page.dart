import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/product_details.dart';

import '../providers/products_data.dart';
import '../widget/nav_menu.dart';

class CartPage extends StatelessWidget {
  final bool showFavourites = false;
  static const route = 'cartpage';

  @override
  Widget build(BuildContext context) {
    final individualItem = Provider.of<ProductData>(context);
    Cart stuff = Provider.of<Cart>(context);
    Orders order = Provider.of<Orders>(context, listen: false);
    List<CartItem> needed = stuff.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping App"),
        actions: [NavMenu()],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          stuff.items.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 5, left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          var transfer = individualItem.items.firstWhere(
                              (element) =>
                                  element.title == needed[index].title &&
                                  element.price == needed[index].price);
                          Navigator.of(context).pushNamed(ProductDetails.route,
                              arguments: transfer);
                        },
                        splashColor: Theme.of(context).primaryColorLight,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          tileColor: Theme.of(context).accentColor,
                          leading: CircleAvatar(
                              child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text("\$${needed[index].price}")),
                              ),
                              backgroundColor: Theme.of(context).primaryColor),
                          title: Text(needed[index].title),
                          subtitle: Text("Total Amount: \$" +
                              (needed[index].price * needed[index].quantity)
                                  .toStringAsFixed(2)),
                          trailing: Text("${needed[index].quantity}x"),
                        ),
                      ),
                    );
                  }),
                  itemCount: stuff.itemCount,
                ))
              : Expanded(
                  child: Center(
                    child: Image.asset("images/empty.gif"),
                  ),
                ),
          const SizedBox(height: 15),
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: stuff.clearCart,
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Chip(
                    label: Text('\$' + stuff.totalAmount.toStringAsFixed(2)),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  TextButton.icon(
                      onPressed: (() {
                        order.addOrder(
                            stuff.items.values.toList(), stuff.totalAmount);
                        stuff.clearCart();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text("Successfully CheckedOut Item"),
                          action: SnackBarAction(
                              label: "Undo",
                              onPressed: () => order.removeLastOrder()),
                        ));
                      }),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: const Text("Checkout"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
