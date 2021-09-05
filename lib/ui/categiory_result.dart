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

// class CategioryResult extends StatelessWidget {
//   // CategioryProductProvider ppc;
//   // List<ProductModel> productModel;
//   List<ProductModel> products;
//   List<CategoryModel> categories;
//   //int index;
//   CategioryResult(this.products);

//   //getCategoryProducts(id);
//   @override
//   Widget build(BuildContext context) {
//     int index;
//     // String id = categories[index].id;
//     Provider.of<CategioryProductProvider>(context, listen: false)
//         .getCategoryProducts(categories[index].id);

//     // = ppc.getCategoryProducts(id);

//     return Scaffold(
//       body: Container(
//           child: Column(children: [
//         Text(//Provider.of<CategioryProductProvider>(context)
//             products[index].productName),
//         Expanded(
//           child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//               ),
//               itemCount: // Provider.of<CategioryProductProvider>(context)
//                   products.length,
//               itemBuilder: (c, index) {
//                 return InkWell(
//                   onTap: () {
//                     AppRouter.router
//                         .pushReplacementToNewWidget(Productdetail());
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 5),
//                     height: 90,
//                     width: 160,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                             colorFilter: ColorFilter.mode(
//                                 Colors.black.withOpacity(0.3),
//                                 BlendMode.darken),
//                             fit: BoxFit.cover,
//                             image: NetworkImage(products[index].imageUrl))),
//                   ),
//                   // ProductItem(
//                   //    products),
//                 );
//               }),
//         ),
//       ])),
//     );
//   }
// }

// class ProductsWidget extends StatelessWidget {
//   List<ProductModel> products;
//   List<CategoryModel> categories;
//   ProductsWidget(this.products);
//   int index;
//   @override
//   Widget build(BuildContext context) {
//     // Provider.of<CategioryProductProvider>(context, listen: false)
//     //     .getCategories();
//     // Provider.of<CategioryProductProvider>(context, listen: false)
//     //     .getCategoryProducts(categories[index].id);
//     // TODO: implement build
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         return InkWell(
//           onTap: () {
//             AppRouter.router.pushToNewWidget(Productdetail(
//                 Provider.of<CategioryProductProvider>(context, listen: false)
//                     .products));
//           },
//           child: SingleChildScrollView(
//             child: Container(
//               color: Colors.grey.withOpacity(0.2),
//               height: 180,
//               //width: ,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     height: 160,
//                     margin: EdgeInsets.all(5),
//                     child: Image.network(
//                       products[index].imageUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Column(
//                         children: [
//                           Text(products[index].productName),
//                           Text(products[index].price.toString()),
//                         ],
//                       ),
//                       Spacer(),
//                       IconButton(
//                           onPressed: () {
//                             Provider.of<CategioryProductProvider>(context,
//                                     listen: false)
//                                 .addToCart(products[index]);
//                           },
//                           icon: Icon(Icons.add))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// class catresult extends StatelessWidget {
//   List<ProductModel> products;
//   catresult(this.products);
//   int index;
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(products[index].productName),
//         ),
//         body: Container(
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 mainAxisSpacing: 20, crossAxisSpacing: 20, crossAxisCount: 2),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               return SingleChildScrollView(
//                 child: Container(
//                   color: Colors.grey.withOpacity(0.2),
//                   height: 200,
//                   width: 200,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Container(
//                         height: 100,
//                         margin: EdgeInsets.all(5),
//                         child: Image.network(
//                           products[index].imageUrl,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Column(
//                             children: [
//                               Text(products[index].productName),
//                               Text(products[index].price.toString()),
//                             ],
//                           ),
//                           Spacer(),
//                           IconButton(
//                               onPressed: () {
//                                 Provider.of<CategioryProductProvider>(context,
//                                         listen: false)
//                                     .addToCart(products[index]);
//                               },
//                               icon: Icon(Icons.add))
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ));
//   }
// }
class catresult extends StatelessWidget {
  //ProductModel products;
  String catname;
  //, image, productName;
  List<ProductModel> pp;
  catresult(this.pp, this.catname);
  //this.image, this.productName,
  //     this.catname); //this.image, this.productName, this.catname);
  rr(context) {
    Provider.of<CategioryProductProvider>(context, listen: false)
        .products
        .clear();
  }

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
                        // Row(
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Text(products[index].productName),
                        //         Text(products[index].price.toString()),
                        //       ],
                        //     ),
                        //     Spacer(),
                        //     IconButton(
                        //         onPressed: () {
                        //           Provider.of<CategioryProductProvider>(context,
                        //                   listen: false)
                        //               .addToCart(products[index]);
                        //         },
                        //         icon: Icon(Icons.add))
                        //   ],
                        // ),
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
