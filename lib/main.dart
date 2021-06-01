import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import 'package:flutter_catalog/pages/CartPage.dart';
import 'package:flutter_catalog/pages/SignUpPage.dart';
import 'package:flutter_catalog/pages/SplashScreen.dart';
import 'package:flutter_catalog/pages/loginPage.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'pages/HomePage.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(VxState(store: MyStore(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();
  final _navigatorKey = new GlobalKey<NavigatorState>();

  Future<void> waitAndNavigate(User? user) async {
    await Future.delayed(Duration(seconds: 3), () {
      if (user == null) {
        print('User is currently signed out!');
        _navigatorKey.currentState!.pushReplacementNamed(MyRoutes.loginPage);
      } else {
        // Future.delayed(Duration(seconds: 5), () {});
        print('User is signed in!');
        _navigatorKey.currentState!.pushReplacementNamed(MyRoutes.homePage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme(context),
      navigatorKey: _navigatorKey,
      darkTheme: MyThemes.darkTheme(context),
      // home: SplashScreen(),
      home: FutureBuilder(
          future: _initFirebaseSdk,
          builder: (_, snapshot) {
            // if (snapshot.hasError) return ErrorScreen();

            if (snapshot.connectionState == ConnectionState.done) {
              // Assign listener after the SDK is initialized successfully
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                waitAndNavigate(user);
              });
            }
            return SplashScreen();
          }),
      //initialRoute: MyRoutes.splashSceen, // By default ye hi hota hai
      routes: {
        MyRoutes.loginPage: (context) => LoginPage(),
        MyRoutes.homePage: (context) => HomePage(),
        MyRoutes.cartPage: (context) => CartPage(),
        MyRoutes.signUpPage: (context) => SignUpPage(),
        MyRoutes.splashSceen: (context) => SplashScreen(),
      },
    );
  }
}
