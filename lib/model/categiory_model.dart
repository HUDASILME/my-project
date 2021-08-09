import 'dart:convert';

import 'package:flutter/material.dart';

class CategoryModel {
  String nameAr;
  String imageurl;
  String id;
  CategoryModel({
    @required this.nameAr,
    @required this.imageurl,
    @required this.id,
  });

  Map<String, dynamic> toMap() {
    return {'name': nameAr, 'imageurl': imageurl};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      nameAr: map['name'],
      imageurl: map['imageurl'],
      id: map['id'],
    );
  }
}
