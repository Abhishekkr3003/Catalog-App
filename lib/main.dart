import 'package:flutter/material.dart';
import 'package:flutter_catalog/pages/CartPage.dart';
import 'package:flutter_catalog/pages/ProductDetails.dart';
import 'package:flutter_catalog/pages/loginPage.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'pages/HomePage.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyThemes.lightTheme(context),
      darkTheme: MyThemes.darkTheme(context),
      initialRoute: MyRoutes.homePage, // By default ye hi hota hai
      routes: {
        MyRoutes.loginPage: (context) => LoginPage(),
        MyRoutes.homePage: (context) => HomePage(),
        MyRoutes.cartPage: (context) => CartPage(),
      },
    );
  }
}
