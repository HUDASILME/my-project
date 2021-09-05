//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:newproject/model/product_model.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  int x = 0;
  // List<ProductModel> myList;
  // CategioryProductProvider productProvider;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('my favourit'),
          centerTitle: true),
      body: Consumer<CategioryProductProvider>(
        builder: (context, provider, widget) {
          return provider.cartProducts == null
              ? Center(
                  child: Text('No Products In The cart'),
                )
              : ListView.builder(
                  itemCount: provider.cartProducts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey[200],
                        child: Row(
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    provider.cartProducts[index].imageUrl)),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('name:' +
                                      provider.cartProducts[index].productName),
                                  Text('price:' +
                                      provider.cartProducts[index].price
                                          .toString()),
                                  // Container(
                                  //   child: Row(
                                  //     children: [
                                  //       InkWell(
                                  //           onTap: () {
                                  //             x = x + 1;
                                  //           },
                                  //           child: Icon(Icons.plus_one)),
                                  //       Text(x.toString()),
                                  //       InkWell(
                                  //           onTap: () {
                                  //             x = x - 1;
                                  //           },
                                  //           child: Icon(Icons.minimize))
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  provider.deleteCartProductt(index);
                                },
                                child: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
