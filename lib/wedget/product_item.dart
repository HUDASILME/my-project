import 'package:flutter/material.dart';
import 'package:newproject/model/product_model.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  List<ProductModel> promodel;
  ProductItem(this.promodel);
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Image.network(promodel[index].imageUrl),
        SizedBox(
          height: 10,
        ),
        Text(promodel[index].productName),
        SizedBox(
          height: 10,
        ),
        Text(promodel[index].productDescription),
        SizedBox(
          height: 10,
        ),
        Text(promodel[index].price.toString()),
      ],
    ));
  }
}
