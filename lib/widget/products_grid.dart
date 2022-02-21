import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_data.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool faveState;
  const ProductsGrid(this.faveState);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductData>(context);
    final productList =
        faveState == false ? productData.items : productData.favitems;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 13),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: productList[index],
        child: ProductItem(),
      ),
      padding: const EdgeInsets.all(10),
      itemCount: productList.length,
    );
  }
}
