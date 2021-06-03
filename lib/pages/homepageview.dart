import 'package:flutter/material.dart';
import 'package:flutter_catalog/pages/HomePage.dart';
import 'package:flutter_catalog/pages/drawerPage.dart';

class HomeScreenViewer extends StatelessWidget {
  const HomeScreenViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [DrawerScreen(), HomePage()],
        ),
      ),
    );
  }
}
