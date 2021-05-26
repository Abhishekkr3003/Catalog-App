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
          child: Text(
            "This is $toBePrinted",
            style: TextStyle(
              color: Colors.purple,
              fontStyle: FontStyle.italic,
            ),
            textScaleFactor: 2.0,
          ),
        ),
      ),
    );
  }
}
