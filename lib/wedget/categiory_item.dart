import 'package:flutter/material.dart';
import 'package:newproject/model/categiory_model.dart';

class Catitem extends StatelessWidget {
  int index;
  List<CategoryModel> cat;
  Catitem(this.cat);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Image.network(cat[index].imageurl), Text(cat[index].nameAr)],
      ),
    );
  }
}
