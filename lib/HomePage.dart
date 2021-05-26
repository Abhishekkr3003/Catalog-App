import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  var toBePrinted = "Android App!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog"),
      ),
      drawer: Drawer(),
      body: Center(
        child: Container(
          child: Text("This is $toBePrinted"),
        ),
      ),
    );
  }
}
