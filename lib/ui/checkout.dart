import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newproject/model/ordermodel.dart';
import 'package:newproject/model/user_model.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/ui/controlpage.dart';
import 'package:newproject/ui/googlemap.dart';
import 'package:newproject/ui/home_screen.dart';
import 'package:newproject/utilites/router.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextStyle myStyle = TextStyle(
    fontSize: 18,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CategioryProductProvider productProvider;

  Widget _buildBottomSingleDetail({String startName, String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: myStyle,
        ),
        Text(
          endName,
          style: myStyle,
        ),
      ],
    );
  }

  User user;

  double total;
  List<OrderModel> myList;

  @override
  void initState() {
    productProvider =
        Provider.of<CategioryProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    double subTotal = 0;

    productProvider = Provider.of<CategioryProductProvider>(context);
    productProvider.getCheckOutModelList.forEach((element) {
      subTotal += element.price * element.quentity;
    });
    total = subTotal;
    productProvider.checkOutModel.price = total;
    int index;
    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => ControlPage(),
          ),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Cart page", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ControlPage(),
                ),
              );
            },
          ),
          // actions: <Widget>[
          //   NotificationButton(),
          // ],
        ),
        // bottomNavigationBar: Container(
        //   height: 70,
        //   width: 100,
        //   margin: EdgeInsets.symmetric(horizontal: 10),
        //   padding: EdgeInsets.only(bottom: 15),
        //   child: _buildButton(),
        // ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: ListView.builder(
                    itemCount: myList.length,
                    itemBuilder: (ctx, myIndex) {
                      return CheckOutSingleProduct(
                        index: myIndex,
                        color: myList[myIndex].color,
                        size: myList[myIndex].size,
                        image: myList[myIndex].image,
                        name: myList[myIndex].ordername,
                        price: myList[myIndex].price,
                        quentity: myList[myIndex].quentity,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBottomSingleDetail(
                        startName: "Total",
                        endName: "\$ ${total.toStringAsFixed(2)}",
                      ),
                      Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                // Provider.of<CategioryProductProvider>(context,
                                //         listen: false)
                                //     .addOrder(
                                //         Provider.of<CategioryProductProvider>(
                                //                 context,
                                //                 listen: false)
                                //             .checkOutModelList[index]);

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'الدفع',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                            '  متاح فقط الدفع عند الاستلام يرجى تحديد مكانك'),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () {},
                                              child: Text('اغلاق')),
                                          TextButton(
                                              child: Text('تأكيد الطلب'),
                                              onPressed: () {
                                                AppRouter.router
                                                    .pushToNewWidget(
                                                        MapScreen());
                                                // Provider.of<CategioryProductProvider>(
                                                //         context,
                                                //         listen: false)
                                                //     .getOrders(user.uid);
                                                // if (productProvider
                                                //     .getCheckOutModelList
                                                //     .isNotEmpty) {
                                                //   //add order
                                                //   FirebaseFirestore.instance
                                                //       .collection("Order")
                                                //       .add({
                                                //     "Product": productProvider
                                                //         .getCheckOutModelList
                                                //         .map((c) => {
                                                //               "ProductName":
                                                //                   c.ordername,
                                                //               "ProductPrice":
                                                //                   c.price,
                                                //               "ProductQuetity":
                                                //                   c.quentity,
                                                //               "ProductImage":
                                                //                   c.image,
                                                //               "Product Color":
                                                //                   c.color,
                                                //               "Product Size":
                                                //                   c.size,
                                                //             })
                                                //         .toList(),
                                                //     "TotalPrice": total
                                                //         .toStringAsFixed(2),
                                                //     "UserName": Provider.of<
                                                //                 AuthProvider>(
                                                //             context,
                                                //             listen: false)
                                                //         .userModel
                                                //         .fullName,
                                                //     "UserEmail": user.email,
                                                //     "UserNumber": Provider.of<
                                                //                 AuthProvider>(
                                                //             context,
                                                //             listen: false)
                                                //         .userModel
                                                //         .phoneNumber,
                                                //     "Useraddress": Provider.of<
                                                //                 AuthProvider>(
                                                //             context,
                                                //             listen: false)
                                                //         .userModel
                                                //         .city,
                                                //    "UserId": user.uid,
                                                //   });
                                                // }
                                                // }
                                              })
                                        ],
                                      );
                                    });
                              },
                              child: Text('buy')))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckOutSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final int index;
  final String color;
  final String size;
  final quentity;
  final double price;
  CheckOutSingleProduct({
    this.index,
    this.color,
    this.size,
    this.quentity,
    this.image,
    this.name,
    this.price,
  });
  @override
  _CheckOutSingleProductState createState() => _CheckOutSingleProductState();
}

TextStyle myStyle = TextStyle(fontSize: 18);
CategioryProductProvider productProvider;

class _CheckOutSingleProductState extends State<CheckOutSingleProduct> {
  double height, width;
  Widget _buildImage() {
    return Container(
      height: height * 0.1 + 50,
      width: width * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(widget.image),
        ),
      ),
    );
  }

  Widget _buildNameAndClosePart() {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.name,
            style: myStyle,
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              productProvider.deleteCartProduct(widget.index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorAndSizePart() {
    return Container(
      width: width * 0.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.color,
            style: myStyle,
          ),
          Text(
            widget.size,
            style: myStyle,
          )
        ],
      ),
    );
  }

  Widget _buildCountOrNot() {
    return Container(
      height: 35,
      width: width * 0.2 + 20,
      color: Color(0xfff2f2f2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Quentity"),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              widget.quentity.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<CategioryProductProvider>(context);

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.2,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  _buildImage(),
                  Container(
                    height: height * 0.1 + 50,
                    width: width * 0.6,
                    child: ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildNameAndClosePart(),
                          _buildColorAndSizePart(),
                          Text(
                            "\$${widget.price.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: Color(0xff9b96d6),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          _buildCountOrNot(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
