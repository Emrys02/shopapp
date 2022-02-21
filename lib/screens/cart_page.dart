import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';

import '../widget/nav_menu.dart';

class CartPage extends StatelessWidget {
  final bool showFavourites = false;
  static const route = 'cartpage';

  @override
  Widget build(BuildContext context) {
    Cart stuff = Provider.of<Cart>(context);
    List<CartItem> needed = stuff.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping App"),
        actions: [NavMenu()],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 10, right: 10),
                child: InkWell(
                  onTap: (() => print(needed[index].title)),
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
          )),
          SizedBox(height: 15),
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
                      ),),
                  SizedBox(
                    height: 10,
                  ),
                  Chip(
                    label: Text('\$' + stuff.totalAmount.toStringAsFixed(2)),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  TextButton(onPressed: () {}, child: const Text('Order Now'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
