import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newproject/admin/admin_mainpage.dart';
import 'package:newproject/helper/auth_helper.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/ui/home_screen.dart';
import 'package:newproject/ui/register_screen.dart';
import 'package:provider/provider.dart';

import 'controlpage.dart';
import 'login_screen.dart';

class SplachScreen extends StatelessWidget {
  int index;
  User u;

  @override
  Widget build(BuildContext context) {
    Provider.of<CategioryProductProvider>(context, listen: false)
        .getCategories();

    Provider.of<CategioryProductProvider>(context, listen: false).getCart();
    Provider.of<CategioryProductProvider>(context, listen: false).getfavouirt();

    // Provider.of<CategioryProductProvider>(context, listen: false).getSliders();
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<AuthProvider>(context, listen: false).getCurrentUser());
    // Provider.of<CategioryProductProvider>(context, listen: false)
    //     .getOrders(u.uid);
    // TODO: implement build
    return ControlPage();
    //AdminMainPage();
    // Scaffold(
    //   body: Center(
    //     child: GestureDetector(
    //         onTap: () {
    //           AuthHelper.authHelper.logout();
    //         },
    //         child: FlutterLogo()),
  }
}
