import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class SingleOrder extends StatefulWidget {
  final OrderItem orderItem;
  SingleOrder(this.orderItem);

  bool showMore = false;

  @override
  State<SingleOrder> createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  toggleShowMore() {
    setState(() {
      widget.showMore = !widget.showMore;
    });
    return widget.showMore;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("\$${widget.orderItem.amount.toStringAsFixed(2)}"),
            subtitle: Text(
                DateFormat('dd MM yyyy hh:mm').format(widget.orderItem.time)),
            trailing: IconButton(
              icon: !widget.showMore
                  ? const Icon(Icons.expand_more_rounded)
                  : const Icon(Icons.expand_less_rounded),
              onPressed: () => toggleShowMore(),
            ),
          ),
          if (widget.showMore)
            SizedBox(
              height: min(widget.orderItem.products.length *50, 200),
              child: ListView.builder(
                itemCount: widget.orderItem.products.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(widget.orderItem.products[index].title),
                  trailing: Text(
                      "${widget.orderItem.products[index].quantity}x ${widget.orderItem.products[index].price}"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
