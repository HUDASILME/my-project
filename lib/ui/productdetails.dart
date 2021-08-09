import 'package:flutter/material.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:provider/provider.dart';

class Productdetail extends StatelessWidget {
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Container(
              child: Image.network(
                  Provider.of<CategioryProductProvider>(context)
                      .products[index]
                      .imageUrl,
                  fit: BoxFit.cover),
            ),
          ],
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () {
                  //favorite
                },
                child: Icon(
                  Icons.favorite,
                ))),
        Row(
          children: [
            Container(
              child: Row(
                children: [
                  Text('size'),
                  SizedBox(
                    width: 30,
                  ),
                  Text(Provider.of<CategioryProductProvider>(context)
                      .products[index]
                      .sizes)
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Row(
                children: [
                  Text('size'),
                  SizedBox(
                    width: 30,
                  ),
                  Text(Provider.of<CategioryProductProvider>(context)
                      .products[index]
                      .sizes)
                ],
              ),
            )
          ],
        ),
        Text('Detailes'),
        Text(Provider.of<CategioryProductProvider>(context)
            .products[index]
            .productDescription),
        Row(
          children: [
            Column(
              children: [
                Text('price'),
                Text(Provider.of<CategioryProductProvider>(context)
                    .products[index]
                    .price
                    .toString())
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  //addtoCART
                  Provider.of<CategioryProductProvider>(context)
                      .cartProducts
                      .add(Provider.of<CategioryProductProvider>(context)
                          .products[index]);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text('add'))
          ],
        )
      ]),
    );
  }
}
