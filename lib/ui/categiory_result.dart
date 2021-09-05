import 'package:flutter/material.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/model/product_model.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/ui/controlpage.dart';
import 'package:newproject/ui/home_screen.dart';
import 'package:newproject/ui/productdetails.dart';
import 'package:newproject/utilites/router.dart';
import 'package:newproject/wedget/product_item.dart';
import 'package:provider/provider.dart';

class catresult extends StatelessWidget {
  String catname;

  List<ProductModel> pp;
  catresult(this.pp, this.catname);

  // rr(context) {
  //   Provider.of<CategioryProductProvider>(context, listen: false)
  //       .products
  //       .clear();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        // Provider.of<CategioryProductProvider>(context, listen: false)
        //     .clearproduct();

        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => ControlPage(),
          ),
        );
      },
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.backpack),
                tooltip: 'back to home',
                onPressed: () {
                  Provider.of<CategioryProductProvider>(context, listen: false)
                      .products
                      .clear();
                },
              ),
            ],
            backgroundColor: Colors.green,
            title: Text(catname),
          ),
          body: Container(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20, crossAxisSpacing: 20, crossAxisCount: 2),
              itemCount:
                  // Provider.of<CategioryProductProvider>(context, listen: false)
                  //     .products
                  pp.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    AppRouter.router.pushToNewWidget(Productdetail(
                        Provider.of<CategioryProductProvider>(context,
                                listen: false)
                            .products[index]
                            .imageUrl,
                        Provider.of<CategioryProductProvider>(context,
                                listen: false)
                            .products[index]
                            .productName,
                        Provider.of<CategioryProductProvider>(context,
                                listen: false)
                            .products[index]
                            .price,
                        Provider.of<CategioryProductProvider>(context,
                                listen: false)
                            .products[index]
                            .productDescription));
                  },
                  child: Container(
                    color: Colors.grey.withOpacity(0.2),
                    height: 200,
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.all(15),
                          child: Image.network(
                            pp[index].imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          pp[index].productName,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
