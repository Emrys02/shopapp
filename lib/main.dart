import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/cart_page.dart';

import 'providers/cart.dart';
import 'providers/products_data.dart';
import '/screens/product_details.dart';

import 'screens/products_page.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductData()),
        ChangeNotifierProvider(create: (context) => Cart()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: ProductsPage(),
        ),
        routes: {
          ProductsPage.route: (context) => ProductsPage(),
          ProductDetails.route: (context) => ProductDetails(),
          CartPage.route: (context) => CartPage()
        },
      ),
    );
  }
}
