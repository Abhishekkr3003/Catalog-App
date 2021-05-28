import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:flutter_catalog/widgets/HomePageWidgets/CatalogHeader.dart';
import 'package:flutter_catalog/widgets/HomePageWidgets/CatalogShower.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var toBePrinted = "Android App!";

  loadData() async {
    await Future.delayed(Duration(seconds: 5));
    String catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    Map<String, dynamic> decodedJson = jsonDecode(catalogJson);
    var productsData = decodedJson["products"];
    CatalogModel.item = List.from(productsData)
        .map((itemMap) => Item.fromMap(itemMap))
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.cart),
        onPressed: () => Navigator.pushNamed(context, MyRoutes.cartPage),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: MyThemes.creamColor,
          padding: EdgeInsets.only(left: 16, top: 16, right: 16),
          //color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              20.heightBox,
              (CatalogModel.item != null && CatalogModel.item!.length > 0)
                  ? CatalogShower().expand()
                  : Center(
                      child: CircularProgressIndicator(
                        color: MyThemes.darkblue,
                      ),
                    ).expand(),
            ],
          ),
        ),
      ),
    );
  }
}
