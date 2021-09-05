//import 'dart:js';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newproject/admin/admin_mainpage.dart';
import 'package:newproject/helper/admin_firestorehelper.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/model/product_model.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/ui/categiory_result.dart';
import 'package:newproject/ui/checkout.dart';
import 'package:newproject/ui/productdetails.dart';
import 'package:newproject/ui/search.dart';
import 'package:newproject/utilites/router.dart';
import 'package:newproject/wedget/categiory_item.dart';
// import 'package:newproject/ui/productdetails.dart';
// import 'package:newproject/utilites/router.dart';
// import 'package:newproject/wedget/categiory_item.dart';
// import 'package:newproject/wedget/product_item.dart';
//import 'io.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  int index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Home Page',
          ),
          actions: [
            Visibility(
                visible: Provider.of<AuthProvider>(context, listen: false)
                    .userModel
                    .isAdmin,
                child: IconButton(
                    onPressed: () {
                      AppRouter.router.pushToNewWidget(AdminMainPage());
                    },
                    icon: Icon(Icons.settings))),
            GestureDetector(
                onTap: () {
                  AppRouter.router.pushToNewWidget(CheckOut());
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Badge(
                    stackFit: StackFit.passthrough,

                    position: BadgePosition.bottomEnd(),
                    badgeContent: Text(
                        Provider.of<CategioryProductProvider>(context)
                            .checkOutModelList
                            .length
                            .toString()),

                    child: Icon(Icons.shopping_cart),
                    // child: IconButton(
                    //     onPressed: () {
                    //       AppRouter.router.pushToNewWidget(CartPage());
                    //     },
                    //     icon: Icon(Icons.shopping_cart)),
                  ),
                ))
          ]),

      // ],
      //  ),
      body: Consumer<CategioryProductProvider>(
        builder: (context, provider, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200),
                child: TextFormField(
                    onTap: () {
                      AppRouter.router.pushToNewWidget(search());
                    },
                    decoration: InputDecoration(
                      hintText: ('search for categiories'),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    )),
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height / 4,
              //   child: SliderWidget(provider.sliders),
              // ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('Categories',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              // RaisedButton(
              //   onPressed: () {
              //     print(provider.categories[0].imageurl);
              //   },
              // ),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 120,
                  child: CategoriesList(provider.categories)),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('last Products',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    )),
              ),
              Expanded(
                child: provider.products == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: EdgeInsets.all(10),
                        child: GestureDetector(
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
                            child: ProductsWidget(provider.products))),
              )
            ],
          );
        },
      ),
    );
  }
}

// class SliderWidget extends StatelessWidget {
//   List<SliderModel> sliders;
//   SliderWidget(this.sliders);
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return CarouselSlider(
//       options: CarouselOptions(autoPlay: true, height: 400.0),
//       items: sliders.map((i) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.symmetric(horizontal: 2),
//                 decoration: BoxDecoration(color: Colors.amber),
//                 child: Image.network(
//                   i.imagePath,
//                   fit: BoxFit.cover,
//                 ));
//           },
//         );
//       }).toList(),
//     );
//   }
// }

class CategoriesList extends StatelessWidget {
  List<CategoryModel> categories;
  CategoriesList(this.categories);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Provider.of<CategioryProductProvider>(context, listen: false)
                  .getCategoryProducts(categories[index].id);
              // AppRouter.router.pushToNewWidget(catresult(
              //     Provider.of<CategioryProductProvider>(context, listen: false)
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(categories[index].imageurl),
                    maxRadius: 40,
                    backgroundColor: Colors.grey,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Provider.of<CategioryProductProvider>(context,
                              listen: false)
                          .getCategoryProducts(categories[index].id);
                      AppRouter.router.pushToNewWidget(catresult(
                          Provider.of<CategioryProductProvider>(context,
                                  listen: false)
                              .products,
                          Provider.of<CategioryProductProvider>(context,
                                  listen: false)
                              .categories[index]
                              .nameAr));
                    },
                    child: Text(categories[index].nameAr))
              ],
            ),
          );
        });
  }
}

class ProductsWidget extends StatelessWidget {
  List<ProductModel> pr;
  ProductsWidget(this.pr);

  @override
  Widget build(BuildContext context) {
    // for (int i = 0; i >= 5; i++) {
    //   if (i == (products.length) - 5) {
    //     break;
    //   }
    //   else{
    // TODO: implement build
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
      itemCount: pr.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey.withOpacity(0.2),
          height: 250,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 150,
                  margin: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      AppRouter.router.pushToNewWidget(Productdetail(
                          pr[index].imageUrl,
                          pr[index].productDescription,
                          pr[index].price,
                          pr[index].productName));
                    },
                    child: Image.network(
                      pr[index].imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(pr[index].productName),
                        Text(pr[index].price.toString()),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Provider.of<CategioryProductProvider>(context,
                                  listen: false)
                              .addToCart(pr[index], index);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: pr[index].isfav ? Colors.white : Colors.red,
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
