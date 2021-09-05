import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class OrderModel {
  String orderid;
  String ordername;
  String image;
  double price;
  int quentity;
  String color;
  String size;
  OrderModel({
    @required this.price,
    this.ordername,
    this.image,
    this.size,
    this.color,
    this.quentity,
  });

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'name': ordername,
      'image': image,
      'size': size,
      'color': color,
      'quentity': quentity
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
        ordername: map['name'],
        price: map['price'],
        size: map['size'],
        color: map['color'],
        quentity: map['quentity']);
  }
}
