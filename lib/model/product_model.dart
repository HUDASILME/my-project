import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ProductModel {
  String id;
  bool isfav;
  String catId;
  String productName;
  String productDescription;
  double price;
  String imageUrl;
  FieldValue createdTime;
  ProductModel(
      {@required this.catId,
      this.id,
      @required this.productName,
      @required this.productDescription,
      @required this.price,
      @required this.imageUrl,
      @required this.createdTime,
      @required this.isfav = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'catId': catId,
      'productName': productName,
      'productDescription': productDescription,
      'price': price,
      'imageUrl': imageUrl,
      'createdTime': createdTime,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      catId: map['catId'],
      productName: map['productName'],
      productDescription: map['productDescription'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      // createdTime: map['createdTime'],
    );
  }
}
