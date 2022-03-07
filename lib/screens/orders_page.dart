import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/widget/nav_menu.dart';
import 'package:shopapp/widget/single_order.dart';

import '../providers/auth.dart';

class OrdersPage extends StatelessWidget {
  static const route = "Orders_page";
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        actions: [NavMenu()],
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).retrieveOrders(auth.authtoken, auth.userID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.error == true) {
            return const Center(
              child: Text("An error occured"),
            );
          } else {
            return Consumer<Orders>(
                builder: (BuildContext context, ordersData, Widget? child) {
              return RefreshIndicator(
                onRefresh: () => Provider.of<Orders>(context, listen: false)
                    .retrieveOrders(auth.authtoken, auth.userID),
                child: ListView.builder(
                  itemCount: ordersData.orders.length,
                  itemBuilder: ((context, i1) =>
                      SingleOrder(ordersData.orders[i1])),
                ),
              );
            });
          }
        },
      ),
    );
  }
}
