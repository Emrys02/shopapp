import 'package:flutter/material.dart';

import '../providers/product.dart';
import '../screens/update_product_page.dart';

class UserProductItems extends StatelessWidget {
  final Product item;
  final Function delete;

  const UserProductItems(this.item, this.delete,);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Column(children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.imageUrl.toString()),
          ),
          title: Text(item.title.toString()),
          subtitle: Text("\$"+item.price.toString()),
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: ()=>delete(item),
                  icon: Icon(
                    Icons.delete_forever_rounded,
                    color: Theme.of(context).errorColor,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(UpdateProduct.route, arguments: item),
                  icon: const Icon(
                    Icons.edit_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ]),
    );
  }
}
