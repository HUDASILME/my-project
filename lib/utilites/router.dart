import 'package:flutter/material.dart';
 
class AppRouter {
  AppRouter._();
  static AppRouter router = AppRouter._();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  pushToNewWidget(Widget widget) {
    navigatorKey.currentState.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  pushReplacementToNewWidget(Widget widget) {
    navigatorKey.currentState
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
