import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/widget/nav_menu.dart';

class OrdersPage extends StatefulWidget {
  static const route = "Orders_page";
  bool showMore = false;

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  toggleShowMore() {
    setState(() {
      widget.showMore = !widget.showMore;
      print(widget.showMore);
    });
    return widget.showMore;
  }

  @override
  Widget build(BuildContext context) {
    Orders ordersData = Provider.of<Orders>(context);
    print(widget.showMore);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
          actions: [NavMenu()],
        ),
        body: ordersData.orders.isNotEmpty
            ? ListView.builder(
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
                                ? Icon(Icons.expand_more_rounded)
                                : Icon(Icons.expand_less_rounded),
                            onPressed: () => toggleShowMore(),
                          ),
                        ),
                        if (widget.showMore)
                          Container(height: 100, child: ListView.builder(itemCount: ordersData.orders[i1].products.length,
                            itemBuilder: (context, index) {
                              return Text(
                                  ordersData.orders[i1].products[index].title);
                            },
                          )),
                      ],
                    ),
                  );
                }),
              )
            : Center(
                child: Image.asset("images/empty.gif"),
              ));
  }
}
