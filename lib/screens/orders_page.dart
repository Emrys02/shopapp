import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/products_page.dart';
import 'package:shopapp/widget/nav_menu.dart';

class OrdersPage extends StatefulWidget {
  static const route = "Orders_page";
  bool showMore = false;
  bool isLoading = false;
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  toggleShowMore() {
    setState(() {
      widget.showMore = !widget.showMore;
    });
    return widget.showMore;
  }
  @override
  void initState() {
    Future.delayed(Duration.zero, () async{
      try{
        setState(() {
          isLoading = true;
        });
        await Provider.of<Orders>(context, listen: false).retrieveOrders();
      }finally{setState(() {
        isLoading = false;
      });}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orders ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        actions: [NavMenu()],
      ),
      body: ordersData.orders.isNotEmpty
          ? RefreshIndicator(
              onRefresh: () =>
                  Provider.of<Orders>(context, listen: false).retrieveOrders(),
              child: ListView.builder(
                itemCount: ordersData.orders.length,
                itemBuilder: ((context, i1) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              "\$${ordersData.orders[i1].amount.toStringAsFixed(2)}"),
                          subtitle: Text(DateFormat('dd MM yyyy hh:mm')
                              .format(ordersData.orders[i1].time)),
                          trailing: IconButton(
                            icon: !widget.showMore
                                ? const Icon(Icons.expand_more_rounded)
                                : const Icon(Icons.expand_less_rounded),
                            onPressed: () => toggleShowMore(),
                          ),
                        ),
                        if (widget.showMore)
                          SizedBox(
                              height: 100,
                              child: ListView.builder(
                                itemCount:
                                    ordersData.orders[i1].products.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(ordersData
                                        .orders[i1].products[index].title),
                                    subtitle: Text(
                                        "\$${ordersData.orders[i1].products[index].price}    x${ordersData.orders[i1].products[index].quantity}"),
                                    trailing: Text((ordersData.orders[i1]
                                                .products[index].price *
                                            ordersData.orders[i1]
                                                .products[index].quantity)
                                        .toStringAsFixed(2)),
                                  );
                                },
                              )),
                      ],
                    ),
                  );
                }),
              ))
          : Center(
              child: RefreshIndicator(
                onRefresh: () => ordersData.retrieveOrders(),
                child: Image.asset("images/empty.gif"),
              ),
            ),
    );
  }
}
