//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:newproject/helper/auth_helper.dart';
import 'package:newproject/model/user_model.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/wedget/custom_textfeild.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  String fullname;
  String email;

  String password;

  String repeatedPassword;

  setEmail(String value) {
    this.email = value;
  }

  setPassword(String value) {
    this.password = value;
  }

  setPassword2(String value) {
    this.repeatedPassword = value;
  }

  setFullName(String value) {
    this.fullname = value;
  }

  nullValidation(String value) {
    if (value.length == 0) {
      return 'Required field';
    }
  }

  validateRepeatedPassword(String value) {
    if (value != this.password) {
      return 'the entered passwords are not matched';
    }
  }

  register() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      UserModel userModel = UserModel(
        email: this.email,
        fullname: this.fullname,
        password: this.password,
        //  isAdmin: this.groubVale == 2,
      );
      AuthHelper.authHelper.register(email, password);
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register new user'),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Form(
                key: Provider.of<AuthProvider>(context).registerKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: Provider.of<AuthProvider>(context)
                            .fullNameController,
                        labelText: 'FullName',
                        validationFunction:
                            Provider.of<AuthProvider>(context, listen: false)
                                .nullValidation,
                      ),
                      CustomTextField(
                        controller:
                            Provider.of<AuthProvider>(context).emailController,
                        labelText: 'email',
                        validationFunction:
                            Provider.of<AuthProvider>(context, listen: false)
                                .nullValidation,
                      ),
                      CustomTextField(
                        controller: Provider.of<AuthProvider>(context)
                            .passwordController,
                        labelText: 'password',
                        validationFunction:
                            Provider.of<AuthProvider>(context, listen: false)
                                .nullValidation,
                      ),
                      CustomTextField(
                        controller: Provider.of<AuthProvider>(context)
                            .passwordController,
                        labelText: 'repeat password',
                        validationFunction:
                            Provider.of<AuthProvider>(context, listen: false)
                                .validateRepeatedPassword,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .registerUser();
                    },
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(backgroundColor: Colors.green),
                    )),
              )
            ],
          )),
    );
  }
}
