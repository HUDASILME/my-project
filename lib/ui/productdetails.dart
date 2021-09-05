import 'package:flutter/material.dart';
import 'package:newproject/model/product_model.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/ui/home_screen.dart';
import 'package:provider/provider.dart';

import 'checkout.dart';

// class Productdetail extends StatefulWidget {
//   List<ProductModel> products;
//   Productdetail(this.products);

//   @override
//   _ProductdetailState createState() => _ProductdetailState();
// }

// class _ProductdetailState extends State<Productdetail> {
//   int index;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(children: [
//         Column(
//           children: [
//             Container(
//               child: Image.network(widget.products[index].imageUrl,
//                   fit: BoxFit.cover),
//             ),
//           ],
//         ),
//         Align(
//             alignment: Alignment.centerLeft,
//             child: InkWell(
//                 onTap: () {
//                   //favorite
//                 },
//                 child: Icon(
//                   Icons.favorite,
//                 ))),
//         Row(
//           children: [
//             Container(
//               child: Row(
//                 children: [
//                   Text('size'),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   // Text(Provider.of<CategioryProductProvider>(context)
//                   //     .products[index]
//                   //     .sizes)
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Container(
//               child: Row(
//                 children: [
//                   Text('size'),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   Text(widget.products[index].price.toString())
//                 ],
//               ),
//             )
//           ],
//         ),
//         Text('Detailes'),
//         Text(widget.products[index].productDescription),
//         Row(
//           children: [
//             Column(
//               children: [
//                 Text('price'),
//                 Text(widget.products[index].price.toString())
//               ],
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   //addtoCART
//                   Provider.of<CategioryProductProvider>(context)
//                       .cartProducts
//                       .add(Provider.of<CategioryProductProvider>(context)
//                           .products[index]);
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.green),
//                 ),
//                 child: Text('add'))
//           ],
//         )
//       ]),
//     );
//   }
// }

class Productdetail extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String description;
  Productdetail(this.image, this.name, this.price, this.description);

  @override
  _ProductdetailState createState() => _ProductdetailState();
}

class _ProductdetailState extends State<Productdetail> {
  int count = 1;
  CategioryProductProvider productProvider;

  Widget _buildColorProduct({Color color}) {
    return Container(
      height: 40,
      width: 40,
      color: color,
    );
  }

  final TextStyle myStyle = TextStyle(
    fontSize: 18,
  );
  Widget _buildImage() {
    return Center(
      child: Container(
        width: 380,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescriptionPart() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.name, style: myStyle),
              Text(
                "\$ ${widget.price.toString()}",
                style: TextStyle(
                    color: Color(0xff9b96d6),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text("Description", style: myStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscription() {
    return Container(
      height: 170,
      child: Wrap(
        children: <Widget>[
          Text(
            widget.description,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  List<bool> sized = [true, false, false, false];
  List<bool> colored = [true, false, false, false];
  int sizeIndex = 0;
  String size;
  void getSize() {
    if (sizeIndex == 0) {
      setState(() {
        size = "S";
      });
    } else if (sizeIndex == 1) {
      setState(() {
        size = "M";
      });
    } else if (sizeIndex == 2) {
      setState(() {
        size = "L";
      });
    } else if (sizeIndex == 3) {
      setState(() {
        size = "XL";
      });
    }
  }

  int colorIndex = 0;
  String color;
  void getColor() {
    if (colorIndex == 0) {
      setState(() {
        color = "Light Blue";
      });
    } else if (colorIndex == 1) {
      setState(() {
        color = "Light Green";
      });
    } else if (colorIndex == 2) {
      setState(() {
        color = "Light Yellow";
      });
    } else if (colorIndex == 3) {
      setState(() {
        color = "Cyan";
      });
    }
  }

  Widget _buildSizePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Size",
          style: myStyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: ToggleButtons(
            children: [
              Text("S"),
              Text("M"),
              Text("L"),
              Text("XL"),
            ],
            onPressed: (int index) {
              setState(() {
                for (int indexBtn = 0; indexBtn < sized.length; indexBtn++) {
                  if (indexBtn == index) {
                    sized[indexBtn] = true;
                  } else {
                    sized[indexBtn] = false;
                  }
                }
              });
              setState(() {
                sizeIndex = index;
              });
            },
            isSelected: sized,
          ),
        ),
      ],
    );
  }

  Widget _buildColorPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          "Color",
          style: myStyle,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 265,
          child: ToggleButtons(
            fillColor: Color(0xff746bc9),
            renderBorder: false,
            children: [
              _buildColorProduct(color: Colors.blue[200]),
              _buildColorProduct(color: Colors.green[200]),
              _buildColorProduct(color: Colors.yellow[200]),
              _buildColorProduct(color: Colors.cyan[300]),
            ],
            onPressed: (int index) {
              setState(() {
                for (int indexBtn = 0; indexBtn < colored.length; indexBtn++) {
                  if (indexBtn == index) {
                    colored[indexBtn] = true;
                  } else {
                    colored[indexBtn] = false;
                  }
                }
              });
              setState(() {
                colorIndex = index;
              });
            },
            isSelected: colored,
          ),
        ),
      ],
    );
  }

  Widget _buildQuentityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          "Quentity",
          style: myStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
            color: Color(0xff746bc9),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                onTap: () {
                  setState(() {
                    if (count > 1) {
                      count--;
                    }
                  });
                },
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              GestureDetector(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onTap: () {
                  setState(() {
                    count++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonPart() {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
          onPressed: () {
            getSize();
            getColor();

            productProvider.getCheckOutData(
              image: widget.image,
              color: color,
              size: size,
              name: widget.name,
              price: widget.price,
              quentity: count,
            );
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => CheckOut(),
            ));
          },
          child: Text('Add To Cart')),
      //   child: MyButton(
      //     name: "Add To Cart",
      //     onPressed: () {
      //       getSize();
      //       getColor();
      //       productProvider.getCheckOutData(
      //         image: widget.image,
      //         color: color,
      //         size: size,
      //         name: widget.name,
      //         price: widget.price,
      //         quentity: count,
      //       );
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => CheckOut(),
      //         ),
      //       );
      //     },
      //   ),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<CategioryProductProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => HomeScreen(),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Detail Page", style: TextStyle(color: Colors.black)),
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
                  builder: (ctx) => HomeScreen(),
                ),
              );
            },
          ),
          // actions: <Widget>[
          //   NotificationButton(),
          // ],
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              _buildImage(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildNameToDescriptionPart(),
                    _buildDiscription(),
                    _buildSizePart(),
                    _buildColorPart(),
                    _buildQuentityPart(),
                    SizedBox(
                      height: 15,
                    ),
                    _buildButtonPart(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
