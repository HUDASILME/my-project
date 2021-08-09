import 'package:flutter/material.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  int x = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Consumer<CategioryProductProvider>(
        builder: (context, provider, widget) {
          return provider.cartProducts == null
              ? Center(
                  child: Text('No Products In The cart'),
                )
              : ListView.builder(
                  itemCount: provider.cartProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
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
                                Text(provider.cartProducts[index].productName),
                                Text(provider.cartProducts[index].price
                                    .toString()),
                                Container(
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            x = x + 1;
                                          },
                                          child: Icon(Icons.plus_one)),
                                      Text(x.toString()),
                                      InkWell(
                                          onTap: () {
                                            x = x - 1;
                                          },
                                          child: Icon(Icons.minimize))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
