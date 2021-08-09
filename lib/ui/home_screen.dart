//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/model/product_model.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
// import 'package:newproject/ui/productdetails.dart';
// import 'package:newproject/utilites/router.dart';
// import 'package:newproject/wedget/categiory_item.dart';
// import 'package:newproject/wedget/product_item.dart';
import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   @override
//   HomePageState createState() => HomePageState();
// }

// //CategioryProductProvider ppc;

// class HomePageState extends State<HomePage> {
//   // TabController tabController;

//   // myMethod() {
//   //   tabController = TabController(
//   //     length: 3,
//   //   );
//   // }

//   // @override
//   // void initState() {
//   //   // TODO: implement initState

//   //   super.initState();
//   //   myMethod();
//   // }

//   int index = 0;
//   ProductModel productModel;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.only(top: 100, left: 20, right: 20),
//         child: Column(
//           children: [
//             searchTextFormField(),
//             SizedBox(
//               height: 30,
//             ),
//             Text('Categiores'),
//             SizedBox(
//               height: 30,
//             ),
//             listViewCategory(context),
//             SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('last product'),
//                 InkWell(onTap: () {}, child: Text('see all'))
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             listViewLastProducts(context),
//             // Container(
//             //   child: Row(
//             //     children: [
//             //       IconButton(onPressed: () {}, icon: Icon(Icons.explore)),
//             //       SizedBox(
//             //         width: 20,
//             //       ),
//             //       IconButton(onPressed: () {}, icon: Icon(Icons.carpenter)),
//             //       SizedBox(
//             //         width: 20,
//             //       ),
//             //       IconButton(onPressed: () {}, icon: Icon(Icons.person)),
//             //       SizedBox(
//             //         width: 20,
//             //       ),
//             //     ],
//             //   ),
//             // )
//           ],
//         ),
//       ),
//       //             BottomNavigationBar(
//       //   onTap: (index) {
//       //     tabController.animateTo(index);
//       //     this.index = index;
//       //     print(index);
//       //     setState(() {});
//       //   },
//       //   currentIndex: index,
//       //   fixedColor: Colors.brown,
//       //   items: [
//       //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'enter'),
//       //     BottomNavigationBarItem(
//       //         icon: Icon(Icons.gavel_outlined), label: 'see this'),
//       //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'go')
//       //   ],
//       // ),
//       //  ],
//     ));
//   }
// }

// Widget searchTextFormField() {
//   return Container(
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: Colors.grey.shade200,
//     ),
//     child: TextFormField(
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         prefixIcon: Icon(
//           Icons.search,
//           color: Colors.black,
//         ),
//       ),
//     ),
//   );
// }

// Widget listViewCategory(context) {
//   return Container(
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount:
//               Provider.of<CategioryProductProvider>(context).categories.length,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 //categiory result
//               },
//               child: Catitem(
//                   Provider.of<CategioryProductProvider>(context).categories),
//             );
//           }));
// }
// //  itemCount: Provider.of<CategioryProductProvider>(context).categories.length,
// // itemBuilder: (context, index) {
// //   return ProductItem(
// //       Provider.of<Myprovider>(context).products[index],
// //       index);
// // })

// listViewLastProducts(context) {
//   ProductModel productModel;
//   String id = productModel.catId;
//   // ppc.getCategoryProducts(id);
//   return Container(
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount:
//               Provider.of<CategioryProductProvider>(context).products.length,
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: () {
//                 AppRouter.router.pushReplacementToNewWidget(Productdetail());
//               },
//               child: ProductItem(Provider.of<CategioryProductProvider>(context)
//                       .products //.where((element) => false)
//                   ),
//             );
//           }));
// }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        // actions: [
        //   Visibility(
        //       visible: Provider.of<AuthProvider>(context, listen: false)
        //           .userModel
        //           .isAdmin,
        //       child: IconButton(
        //           onPressed: () {
        //             AppRouter.router.pushToNewWidget(AdminMainPage());
        //           },
        //           icon: Icon(Icons.settings))),
        //   GestureDetector(
        //     onTap: () {
        //       AppRouter.router.pushToNewWidget(CartPage());
        //     },
        //     child: Container(
        //       margin: EdgeInsets.symmetric(horizontal: 15),
        //       child: Badge(
        //         stackFit: StackFit.passthrough,

        //         position: BadgePosition.bottomEnd(),
        //         badgeContent: Text(Provider.of<CustomerProvider>(context)
        //             .cartProducts
        //             .length
        //             .toString()),

        //         child: Icon(Icons.shopping_cart),
        //         // child: IconButton(
        //         //     onPressed: () {
        //         //       AppRouter.router.pushToNewWidget(CartPage());
        //         //     },
        //         //     icon: Icon(Icons.shopping_cart)),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Consumer<CategioryProductProvider>(
        builder: (context, provider, widget) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 90,
                  child: CategoriesList(provider.categories)),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text('Products',
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
                        child: ProductsWidget(provider.products)),
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
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 90,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                      fit: BoxFit.cover,
                      image: NetworkImage(categories[index].imageurl))),
            ),
            //   Positioned.fill(
            //       child: Align(
            //     alignment: Alignment.center,
            //     child: Text(categories[index].nameAr,
            //         style: TextStyle(
            //           fontSize: 20,
            //           color: Colors.white,
            //           fontWeight: FontWeight.w700,
            //         )),
            //   ))
            // ],
          );
        });
  }
}

class ProductsWidget extends StatelessWidget {
  List<ProductModel> products;
  ProductsWidget(this.products);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey.withOpacity(0.2),
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 120,
                margin: EdgeInsets.all(5),
                child: Image.network(
                  products[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(products[index].productName),
                      Text(products[index].price.toString()),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Provider.of<CategioryProductProvider>(context,
                                listen: false)
                            .addToCart(products[index]);
                      },
                      icon: Icon(Icons.add))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
