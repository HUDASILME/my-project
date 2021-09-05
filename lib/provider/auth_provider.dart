//import 'dart:html';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:newproject/helper/auth_helper.dart';
import 'package:newproject/helper/firestor_helper.dart';
import 'package:newproject/helper/firestorage_helper.dart';
import 'package:newproject/model/user_model.dart';
import 'package:newproject/ui/controlpage.dart';
import 'package:newproject/ui/home_screen.dart';
import 'package:newproject/ui/login_screen.dart';
import 'package:newproject/ui/profile.dart';
import 'package:newproject/utilites/router.dart';

class AuthProvider extends ChangeNotifier {
  int isAdmin = 0;
  toggleIsAdmin(int i) {
    this.isAdmin = i;
    notifyListeners();
  }

  User currentUser;
  UserModel userModel;
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  registerUser() async {
    if (registerKey.currentState.validate()) {
      UserModel userModel = UserModel(
          city: cityController.text,
          email: emailController.text,
          fullName: fullNameController.text,
          password: passwordController.text,
          phoneNumber: phoneNumberController.text,
          isAdmin: isAdmin == 1 ? true : false);
      User user = await AuthHelper.authHelper
          .register(userModel.email, userModel.password);
      FirestoreHelper.firestoreHelper.createNewUser(userModel, user.uid);
      getCurrentUser();
    } else {
      return;
    }
  }

  login() async {
    if (loginKey.currentState.validate()) {
      User user = await AuthHelper.authHelper
          .login(emailController.text, passwordController.text);

      await FirestoreHelper.firestoreHelper.getUser(user.uid);
      getCurrentUser();
    } else {
      return;
    }
  }

  logout() async {
    this.currentUser = null;
    this.userModel = null;
    await FirebaseAuth.instance.signOut();
    emailController.clear();
    passwordController.clear();
    AppRouter.router.pushReplacementToNewWidget(LoginScreen());
  }

  updateUserImage(File file) async {
    String userId = this.currentUser.uid;
    String imageUrl =
        await FirestorageHelper.firestorageHelper.uploadImage(file);
    await FirestoreHelper.firestoreHelper.insertImage(imageUrl, userId);
    getCurrentUser();
  }

  getCurrentUser() async {
    this.currentUser = AuthHelper.authHelper.getCurrentUserId();

    if (currentUser != null) {
      this.userModel =
          await FirestoreHelper.firestoreHelper.getUser(currentUser.uid);
      AppRouter.router.pushReplacementToNewWidget(ControlPage());
    } else {
      AppRouter.router.pushReplacementToNewWidget(LoginScreen());
    }
    notifyListeners();
  }

  nullValidation(String value) {
    if (value.length == 0) {
      return 'Required field';
    }
  }

  validateRepeatedPassword(String value) {
    if (value != this.passwordController.text) {
      return 'the entered passwords are not matched';
    }
  }
}
