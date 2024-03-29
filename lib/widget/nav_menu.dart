import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/screens/orders_page.dart';
import 'package:shopapp/screens/profile.dart';

import '../providers/global_variables.dart';
import '../screens/cart_page.dart';
import '../screens/products_page.dart';

class NavMenu extends StatefulWidget {
  @override
  State<NavMenu> createState() => _NavMenuState();
}

class _NavMenuState extends State<NavMenu> {
  @override
  Widget build(BuildContext context) {
    Cart stuff = Provider.of<Cart>(context, listen: false);
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      iconSize: 30,
      icon: const Icon(Icons.account_circle_rounded),
      onSelected: (FilterOptions value) {
        setState(() {
          if (value == FilterOptions.favourites) {
            Navigator.of(context)
                .pushReplacementNamed(ProductsPage.route, arguments: true);
          }
          if (value == FilterOptions.home) {
            Navigator.of(context)
                .pushReplacementNamed(ProductsPage.route, arguments: false);
          }
          if (value == FilterOptions.cart) {
            Navigator.of(context).pushReplacementNamed(CartPage.route);
          }
          if (value == FilterOptions.checkout) {
            Navigator.of(context).pushReplacementNamed(OrdersPage.route);
          }
          if (value == FilterOptions.account) {
            Navigator.of(context).pushReplacementNamed(Profile.route);
          }
        });
      },
      itemBuilder: ((context) => [
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(
                  Icons.shopping_bag_rounded,
                  color: Colors.blue,
                ),
                title: Text('Shop'),
              ),
              value: FilterOptions.home,
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                ),
                title: Text('Favourites'),
              ),
              value: FilterOptions.favourites,
            ),
            PopupMenuItem(
              child: ListTile(
                leading: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.grey,
                ),
                title: const Text('My Cart'),
                trailing: Text(
                  stuff.itemCount.toString(),
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
              value: FilterOptions.cart,
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.black87,
                ),
                title: Text('Checkout'),
              ),
              value: FilterOptions.checkout,
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black87,
                ),
                title: Text('Profile'),
              ),
              value: FilterOptions.account,
            ),
          ]),
    );
  }
}
