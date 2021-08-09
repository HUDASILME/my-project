import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  Function validationFunction;
  String labelText;
  CustomTextField(
      {@required this.validationFunction,
      @required this.labelText,
      this.controller});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextFormField(
        controller: this.controller,
        validator: (v) => validationFunction(v),
        decoration: InputDecoration(
            labelText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
