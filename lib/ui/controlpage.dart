import 'package:flutter/material.dart';
import 'package:newproject/model/product_model.dart';

import 'cart_screen.dart';
import 'home_screen.dart';
import 'profile.dart';

class ControlPage extends StatefulWidget {
  @override
  _ControlPaageState createState() => _ControlPaageState();
}

class _ControlPaageState extends State<ControlPage> {
  int newcurrentIndex = 0;
  ProductModel productModel;
  final List<Widget> pages = [HomeScreen(), CartPage(), ProfilePage()];

  void onTabTapped(int index) {
    setState(() {
      newcurrentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[newcurrentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //currentIndex: 0,
        onTap: onTabTapped, // new
        currentIndex: newcurrentIndex,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: ('cart'),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ('Profile'))
        ],
      ),
    );
  }
}

//List<Widget> pages = [];
