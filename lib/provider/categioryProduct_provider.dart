import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproject/helper/admin_firestorehelper.dart';
import 'package:newproject/helper/firestorage_helper.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/model/product_model.dart';

class CategioryProductProvider extends ChangeNotifier {
  File file;
  List<CategoryModel> categories;
  List<ProductModel> products;
  List<ProductModel> cartProducts;
  CategoryModel selectedCategoryModel;

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

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
      await AdminFirestoreHelper.adminFirestoreHelper.addProduct(productModel);
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
      await AdminFirestoreHelper.adminFirestoreHelper
          .addCategory(categoryModel);
      clearVariables();
    } else {
      return;
    }
  }

//add new function from another app and add cartmodel
  clearVariables() {
    categoryNameController.clear();
    productNameController.clear();
    productDescController.clear();
    productPriceController.clear();
    this.file = null;
    notifyListeners();
  }

  getCategoryProducts(String id) async {
    List<ProductModel> products =
        await AdminFirestoreHelper.adminFirestoreHelper.getAllProducts(id);
    this.products = products;
    notifyListeners();
  }

  getCategories() async {
    List<CategoryModel> categories =
        await AdminFirestoreHelper.adminFirestoreHelper.getAllCategories();
    this.categories = categories;
    getCategoryProducts(categories.first.id);
    notifyListeners();
  }

  Future<ProductModel> getCart() async {
    cartProducts = await AdminFirestoreHelper.adminFirestoreHelper.getCart();
    notifyListeners();
  }

  addToCart(ProductModel productModel) async {
    await AdminFirestoreHelper.adminFirestoreHelper.addToCart(productModel);
    getCart();
  }

  Future<String> uploadImage(String path) async {
    String imageUrl =
        await FirestorageHelper.firestorageHelper.uploadImage(file, path);
    return imageUrl;
  }
}
