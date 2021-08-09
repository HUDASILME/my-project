import 'package:flutter/material.dart';
import 'package:newproject/model/product_model.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/ui/productdetails.dart';
import 'package:newproject/utilites/router.dart';
import 'package:newproject/wedget/product_item.dart';
import 'package:provider/provider.dart';

class CategioryResult extends StatelessWidget {
  // CategioryProductProvider ppc;
  // List<ProductModel> productModel;
  List<ProductModel> products;
  int index;

  //getCategoryProducts(id);
  @override
  Widget build(BuildContext context) {
    String id = products[index].id;
    // = ppc.getCategoryProducts(id);
    return Scaffold(
      body: Container(
          child: Column(children: [
        Text(Provider.of<CategioryProductProvider>(context)
            .products[index]
            .productName),
        Expanded(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: Provider.of<CategioryProductProvider>(context)
                  .products
                  .length,
              itemBuilder: (c, index) {
                return InkWell(
                  onTap: () {
                    AppRouter.router
                        .pushReplacementToNewWidget(Productdetail());
                  },
                  child: ProductItem(
                      Provider.of<CategioryProductProvider>(context).products),
                );
              }),
        ),
      ])),
    );
  }
}
