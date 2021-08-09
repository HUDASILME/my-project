import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  String userid;
  String fullname;
  String password;
  String email;
  String pic;
  bool isadmin, ismarket, iscustomer;
  UserModel({this.userid, this.fullname, this.password, this.email, this.pic,this.isadmin});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': pic,
      'fullName': fullname,
    };
  }

  UserModel.fromDocumentSnapShot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    this.userid = documentSnapshot.id;
    this.pic = documentSnapshot.data()['imageUrl'];
    this.email = documentSnapshot.data()['email'];

    this.fullname = documentSnapshot.data()['fullName'];

    // this.isAdmin = documentSnapshot.data()['isAdmin'];
  }
}
