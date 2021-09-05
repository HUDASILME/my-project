import 'package:flutter/material.dart';

// Import the firebase_core plugin
//import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newproject/admin/admin_provider.dart';
import 'package:newproject/helper/admin_firestorehelper.dart';
import 'package:newproject/model/categiory_model.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/provider/categioryProduct_provider.dart';
import 'package:newproject/ui/controlpage.dart';
import 'package:newproject/ui/home_screen.dart';
import 'package:newproject/ui/splash_screen.dart';
import 'package:newproject/utilites/router.dart';
import 'package:provider/provider.dart';
//import 'package:flutter/src/widgets/framework.dart';

import 'ui/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MateriapAppIntializing());
}
//api key  AIzaSyA_09w-gG4t9CTnHUjQTRFu9RVhGN-9abU

class MateriapAppIntializing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider<CategioryProductProvider>(
          create: (context) {
            return CategioryProductProvider();
          },
        ),
        ChangeNotifierProvider<AdminProvider>(
          create: (context) {
            return AdminProvider();
          },
        )
      ],
      child:
          MaterialApp(navigatorKey: AppRouter.router.navigatorKey, home: App()),
    );
  }
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Text('ERROR'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return SplachScreen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Text('LOADING'),
        );
      },
    );
  }
}

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(child: RaisedButton(
        onPressed: () async {
          List<CategoryModel> categories = await AdminFirestoreHelper
              .adminFirestoreHelper
              .getAllCategories();
        },
      )),
    );
  }
}
