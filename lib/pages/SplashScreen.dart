import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:flutter_catalog/utils/themes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //     Navigator.pushReplacementNamed(context, MyRoutes.loginPage);
    //   } else {
    //     print('User is signed in!');
    //     Navigator.pushReplacementNamed(context, MyRoutes.homePage);
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme(context),
      //darkTheme: MyThemes.darkTheme(context),
      home: Scaffold(
        backgroundColor: context.cardColor,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/splashImage.jpeg"),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: "Hi".text.make(),
            // )
          ],
        ),
        bottomSheet: Container(
          color: context.cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Cataloap".text.bold.color(context.theme.buttonColor).xl6.make(),
              Icon(CupertinoIcons.cart)
            ],
          ),
        ),
      ),
    );
  }
}
