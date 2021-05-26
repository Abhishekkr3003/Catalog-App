import 'package:flutter/material.dart';
import 'package:flutter_catalog/pages/loginPage.dart';
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
      theme: ThemeData(primarySwatch: Colors.purple),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: "/", // By default ye hi hota hai
      routes: {
        "/": (context) => HomePage(),
        "/loginPage": (context) => LoginPage(),
      },
    );
  }
}
