//import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproject/admin/admin_firestore_helper.dart';
import 'package:newproject/helper/firestorage_helper.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/model/product_model.dart';

class AdminProvider extends ChangeNotifier {
  File file;
  List<CategoryModel> categories;
  List<ProductModel> products;
  CategoryModel selectedCategoryModel;

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController sliderUrlController = TextEditingController();

  GlobalKey<FormState> productKey = GlobalKey<FormState>();
  GlobalKey<FormState> categoryKey = GlobalKey<FormState>();

  selectImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    this.file = File(pickedFile.path);
    notifyListeners();
  }

  nullValidation(String value) {
    if (value.length == 0) {
      return 'Required field';
    }
  }

  addProduct() async {
    if (productKey.currentState.validate()) {
      String imageUrl = await uploadImage('products');
      ProductModel productModel = ProductModel(
        productName: productNameController.text,
        productDescription: productDescController.text,
        price: double.parse(productPriceController.text),
        imageUrl: imageUrl,
        catId: selectedCategoryModel.id,
      );
      await AdmnFirestoreHelper.adminFirestoreHelper.addProduct(productModel);
    } else {
      return;
    }
  }

  selectCategory(CategoryModel categoryModel) {
    this.selectedCategoryModel = categoryModel;
    notifyListeners();
  }

  addCategory(context) async {
    if (categoryKey.currentState.validate()) {
      String imageUrl = await uploadImage('categories');
      CategoryModel categoryModel = CategoryModel(
          nameAr: categoryNameController.text, imageurl: imageUrl);
      await AdmnFirestoreHelper.adminFirestoreHelper.addCategory(categoryModel);
      clearVariables();
    } else {
      return;
    }
  }

  clearVariables() {
    categoryNameController.clear();
    productNameController.clear();
    productDescController.clear();
    productPriceController.clear();
    sliderUrlController.clear();
    this.file = null;
    notifyListeners();
  }

  addSlider() async {
    String imagePath = await uploadImage('sliders');
    await AdmnFirestoreHelper.adminFirestoreHelper
        .addSlider(imagePath, sliderUrlController.text);
    clearVariables();
  }

  Future<String> uploadImage(String path) async {
    String imageUrl =
        await FirestorageHelper.firestorageHelper.uploadImage(file, path);
    return imageUrl;
  }
}
