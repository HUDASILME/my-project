import 'package:flutter/material.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/model/product_model.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:provider/provider.dart';

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
        fixedColor: Colors.green,
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
            icon: Icon(Icons.favorite_border_outlined),
            label: ('my favourit'),
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ('Profile'))
        ],
      ),
    );
  }
}

//List<Widget> pages = [];
