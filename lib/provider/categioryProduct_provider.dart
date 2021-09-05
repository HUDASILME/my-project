import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newproject/helper/admin_firestorehelper.dart';
import 'package:newproject/helper/firestorage_helper.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/model/ordermodel.dart';
import 'package:newproject/model/product_model.dart';

class CategioryProductProvider extends ChangeNotifier {
  File file;
  List<CategoryModel> categories;
  List<ProductModel> products;
  List<ProductModel> cartProducts;
  List<ProductModel> favouritProducts;
  CategoryModel selectedCategoryModel;
  List<OrderModel> checkOutModelList = [];
  OrderModel checkOutModel;

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

  clearproduct() {
    this.products.clear();
    notifyListeners();
  }

  getCategories() async {
    List<CategoryModel> categories =
        await AdminFirestoreHelper.adminFirestoreHelper.getAllCategories();

    this.categories = categories;
    getCategoryProducts(categories.first.id);
    notifyListeners();
  }

  Future<ProductModel> getOrders(String uid) async {
    checkOutModelList =
        await AdminFirestoreHelper.adminFirestoreHelper.getOrders(uid);
    notifyListeners();
  }

  addOrder(OrderModel orderModel, String uid) async {
    await AdminFirestoreHelper.adminFirestoreHelper.addOrder(orderModel, uid);
    getOrders(uid);
  }

  addToCart(ProductModel productModel, int index) async {
    cartProducts[index].isfav = !cartProducts[index].isfav;
    await AdminFirestoreHelper.adminFirestoreHelper.addToCart(productModel);
    getCart();
  }

  Future<ProductModel> getCart() async {
    cartProducts = await AdminFirestoreHelper.adminFirestoreHelper.getCart();
    // cartProducts[index].isfav = true;

    notifyListeners();
  }

  Future<ProductModel> getfavouirt() async {
    favouritProducts =
        await AdminFirestoreHelper.adminFirestoreHelper.getfavouirt();
    notifyListeners();
  }

  addTofavourit(ProductModel productModel) async {
    await AdminFirestoreHelper.adminFirestoreHelper.addTofavourit(productModel);
    // favouritProducts[index].isfav = !favouritProducts[index].isfav;
    getfavouirt();
  }

  void getCheckOutData({
    int quentity,
    double price,
    String name,
    String color,
    String size,
    String image,
  }) {
    checkOutModel = OrderModel(
      color: color,
      size: size,
      price: price,
      ordername: name,
      image: image,
      quentity: quentity,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<OrderModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  void deleteCartProduct(int index) {
    checkOutModelList.removeAt(index);

    notifyListeners();
  }

  void deleteCartProductt(
    int index,
  ) async {
    await //AdminFirestoreHelper.adminFirestoreHelper.deleteCartProduct(id)

        AdminFirestoreHelper.adminFirestoreHelper
            .deleteCartProduct(cartProducts[index].id);
    cartProducts.removeAt(index);
    notifyListeners();
  }

  void deletefavouritProduct(int index) {
    favouritProducts.removeAt(index);
    notifyListeners();
  }

  Future<String> uploadImage(String path) async {
    String imageUrl =
        await FirestorageHelper.firestorageHelper.uploadImage(file, path);
    return imageUrl;
  }
}
