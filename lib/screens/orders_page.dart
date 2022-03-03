import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/widget/nav_menu.dart';
import 'package:shopapp/widget/single_order.dart';

class OrdersPage extends StatelessWidget {
  static const route = "Orders_page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        actions: [NavMenu()],
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).retrieveOrders(),
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
                    .retrieveOrders(),
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
