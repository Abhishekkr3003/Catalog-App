import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  var toBePrinted = "Android App!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(CupertinoIcons.shopping_cart),
          SizedBox(width: 10),
        ],
        title: Text("Catalog App"),
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            child: Text(
              "This is $toBePrinted",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
