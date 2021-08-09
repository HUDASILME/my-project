import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newproject/helper/auth_helper.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/ui/home_screen.dart';
import 'package:newproject/ui/register_screen.dart';
import 'package:newproject/utilites/router.dart';
import 'package:newproject/wedget/custom_textfeild.dart';
import 'package:provider/provider.dart';

import 'controlpage.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Screen'),
//       ),
//       body: Container(
//         child: Form(
//           key: Provider.of<AuthProvider>(context, listen: false).loginKey,
//           child: Column(
//             children: [
//               CustomTextField(
//                 controller: Provider.of<AuthProvider>(context).emailController,
//                 labelText: 'Email',
//                 validationFunction:
//                     Provider.of<AuthProvider>(context, listen: false)
//                         .nullValidation,
//               ),
//               CustomTextField(
//                 controller:
//                     Provider.of<AuthProvider>(context).passwordController,
//                 labelText: 'Password',
//                 validationFunction:
//                     Provider.of<AuthProvider>(context, listen: false)
//                         .nullValidation,
//               ),
//               TextButton(
//                   onPressed: () {
//                     AppRouter.router
//                         .pushReplacementToNewWidget(RegisterScreen());
//                   },
//                   child: Text('Create new user')),
//               ElevatedButton(
//                   onPressed: () {
//                     Provider.of<AuthProvider>(context, listen: false).login();
//                   },
//                   child: Text('Login'))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  // String email;
  // String password;

  // setEmail(String value) {
  //   this.email = value;
  // }

  // setPassword(String value) {
  //   this.password = value;
  // }

  // nullValidation(String value) {
  //   if (value.length == 0) {
  //     return 'Required field';
  //   }
  // }

  // login() {
  //   if (loginFormKey.currentState.validate()) {
  //     loginFormKey.currentState.save();
  //     AuthHelper.authHelper.login(email, password);
  //   }
  // }

  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'welcome',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      TextButton(
                          onPressed: () {
                            AppRouter.router
                                .pushReplacementToNewWidget(RegisterScreen());
                          },
                          child: Text(
                            'sign up',
                            textAlign: TextAlign.left,
                          ))
                    ],
                  ),
                  Text(
                    'sign in to continue',
                    textAlign: TextAlign.start,
                  ),
                  Form(
                    key: Provider.of<AuthProvider>(context, listen: false)
                        .loginKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: Provider.of<AuthProvider>(context)
                              .emailController,
                          labelText: 'Email',
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
                        TextButton(
                            onPressed: () {
                              AppRouter.router
                                  .pushReplacementToNewWidget(RegisterScreen());
                            },
                            child: Text(
                              'register new user',
                              textAlign: TextAlign.right,
                            )),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                              ),
                              onPressed: () {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .login();
                                AppRouter.router
                                    .pushReplacementToNewWidget(ControlPage());
                              },
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.green,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '-OR-',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey[100],
              child: FlatButton(
                  onPressed: () {},
                  minWidth: double.infinity,
                  child: ListTile(
                    leading: Icon(Icons.golf_course),
                    title: Text('sign in with Google'),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.grey[100],
              child: FlatButton(
                  onPressed: () {},
                  minWidth: double.infinity,
                  child: ListTile(
                    leading: Icon(Icons.facebook),
                    title: Text('sign in with facebook'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
