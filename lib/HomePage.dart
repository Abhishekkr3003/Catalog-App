import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  var toBePrinted = "Android App!";
  int p1=1;
  int p2=2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("This is $toBePrinted"),
        ),
      ),
    );
  }
}
