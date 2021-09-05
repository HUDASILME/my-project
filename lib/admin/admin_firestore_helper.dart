import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newproject/model/product_model.dart';

class AdmnFirestoreHelper {
  AdmnFirestoreHelper._();
  static AdmnFirestoreHelper adminFirestoreHelper = AdmnFirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addSlider(String imagePath, String sliderurl) async {
    await firestore
        .collection('sliders')
        .add({'sliderUrl': sliderurl, 'imagePath': imagePath});
  }

  addCategory(categoryModel) async {
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

  getOrders() async {}

  FieldValue getFirestoreTime() {
    return FieldValue.serverTimestamp();
  }
}
