import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/model/ordermodel.dart';
import 'package:newproject/model/ordermodel.dart';
import 'package:newproject/model/ordermodel.dart';
import 'package:newproject/model/ordermodel.dart';
import 'package:newproject/model/product_model.dart';

class AdminFirestoreHelper {
  AdminFirestoreHelper._();
  static AdminFirestoreHelper adminFirestoreHelper = AdminFirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addCategory(CategoryModel categoryModel) async {
    await firestore.collection('categories').add(categoryModel.toMap());
  }

  addProduct(ProductModel productModel) async {
    productModel.createdTime = FieldValue.serverTimestamp();
    await firestore
        .collection('categories')
        .doc(productModel.catId)
        .collection('products')
        .add(productModel.toMap());
  }

  deleteCategory(String id) async {
    await firestore.collection('categories').doc(id).delete();
  }

  deleteProduct(String catId, String id) async {
    await firestore
        .collection('categories')
        .doc(catId)
        .collection('products')
        .doc(id)
        .delete();
  }

  deleteCartProduct(String id) async {
    await firestore.collection('cart').doc(id).delete();
  }

  Future<List<CategoryModel>> getAllCategories() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('categories').get();

    List<CategoryModel> categories = querySnapshot.docs.map((e) {
      Map map = e.data();
      map['id'] = e.id;
      CategoryModel c = CategoryModel.fromMap(map);
      print(c.toMap());
      return c;
    }).toList();
    return categories;
  }

  Future<List<ProductModel>> getAllProducts(String catId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('categories')
        .doc(catId)
        .collection('products')
        .get();
    print(querySnapshot.docs);
    List<ProductModel> products =
        querySnapshot.docs.map((e) => ProductModel.fromMap(e.data())).toList();
    return products;
  }

  getProductDetails() async {}
  addToCart(ProductModel productModel) async {
    await firestore.collection('cart').add(productModel.toMap());
  }

  addTofavourit(ProductModel productModel) async {
    await firestore.collection('favourit').add(productModel.toMap());
  }

  Future<List<ProductModel>> getCart() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('cart').get();
    List<ProductModel> cartproducts =
        querySnapshot.docs.map((e) => ProductModel.fromMap(e.data())).toList();
    return cartproducts;
  }

  Future<List<ProductModel>> getfavouirt() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('favourit').get();
    List<ProductModel> products =
        querySnapshot.docs.map((e) => ProductModel.fromMap(e.data())).toList();
    return products;
  }

  getOrders(String id) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('Users').doc(id).collection('order').get();
    List<OrderModel> checkOutModelList =
        querySnapshot.docs.map((e) => OrderModel.fromMap(e.data())).toList();
    return checkOutModelList;
  }

  addOrder(OrderModel orderModel, String uid) async {
    await firestore
        .collection('users')
        .doc(uid)
        .collection('order')
        .add(orderModel.toMap());
  }

  FieldValue getFirestoreTime() {
    return FieldValue.serverTimestamp();
  }
}
