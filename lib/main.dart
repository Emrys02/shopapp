import 'package:flutter/material.dart';
import 'package:shopapp/screens/product_details.dart';

import 'screens/products_page.dart';

void main()=> runApp(home());

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amberAccent,
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ProductsPage(),
      ),
      routes: {ProductDetails.route:(context) => ProductDetails()},
    );
  }
}
