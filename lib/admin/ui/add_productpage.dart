import 'package:flutter/material.dart';
import 'package:newproject/admin/admin_provider.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/wedget/custom_textfeild.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: Consumer<AdminProvider>(builder: (context, provider, widget) {
        return Container(
          child: Form(
            key: provider.productKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      provider.selectImage();
                    },
                    child: CircleAvatar(
                      radius: 70,
                      child: provider.file == null
                          ? Container(
                              color: Colors.grey,
                            )
                          : Image.file(provider.file),
                    ),
                  ),
                  CustomTextField(
                    labelText: 'Product Name',
                    validationFunction: provider.nullValidation,
                    controller: provider.productNameController,
                  ),
                  CustomTextField(
                    labelText: 'Product Description',
                    validationFunction: provider.nullValidation,
                    controller: provider.productDescController,
                  ),
                  CustomTextField(
                    labelText: 'Product Price',
                    validationFunction: provider.nullValidation,
                    controller: provider.productPriceController,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<CategoryModel>(
                        isExpanded: true,
                        underline: Container(),
                        value: provider.selectedCategoryModel,
                        onChanged: (e) {
                          provider.selectCategory(e);
                        },
                        items: Provider.of<CategioryProductProvider>(context)
                            .categories
                            .map((e) {
                          return DropdownMenuItem<CategoryModel>(
                            child: Text(e.nameAr),
                            value: e,
                          );
                        }).toList()),
                  ),
                  RaisedButton(
                      child: Text('Add Product'),
                      onPressed: () {
                        provider.addProduct();
                      })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
