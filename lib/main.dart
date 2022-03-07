import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/accounts.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/auth_screen.dart';
import 'package:shopapp/screens/available_user_accounts.dart';
import 'package:shopapp/screens/cart_page.dart';
import 'package:shopapp/screens/add_new_product_page.dart';
import 'package:shopapp/screens/orders_page.dart';
import 'package:shopapp/screens/profile.dart';
import 'package:shopapp/screens/update_product_page.dart';
import 'package:shopapp/screens/user_products.dart';
import 'package:shopapp/widget/create_account.dart';

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
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductData>(
            create: (context) => ProductData(""),
            update: (context, auth, previous) => ProductData(auth.authtoken)),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider(create: (context) => AcctDetails()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.amberAccent,
            fontFamily: 'Lato',
            backgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: !auth.isAuth ? AuthScreen() : ProductsPage(),
          ),
          routes: {
            ProductsPage.route: (context) => ProductsPage(),
            ProductDetails.route: (context) => ProductDetails(),
            CartPage.route: (context) => CartPage(),
            OrdersPage.route: (context) => OrdersPage(),
            Profile.route: (context) => Profile(),
            UserProducts.route: (context) => UserProducts(),
            AddNewProductPage.route: (context) => AddNewProductPage(),
            CreateAccount.route: (context) => CreateAccount(),
            UpdateProduct.route: (context) => UpdateProduct(),
            UserAccounts.route: (context) => UserAccounts(),
            AuthScreen.route: (context) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
