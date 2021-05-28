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
    CatalogModel.items = List.from(productsData)
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
        backgroundColor: context.theme.buttonColor,
        child: Icon(
          CupertinoIcons.cart,
          color: MyThemes.creamColor,
        ),
        onPressed: () => Navigator.pushNamed(context, MyRoutes.cartPage),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          color: context.canvasColor,
          padding: EdgeInsets.only(left: 16, top: 16, right: 16),
          //color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              20.heightBox,
              (CatalogModel.items != null && CatalogModel.items!.length > 0)
                  ? CatalogShower().expand()
                  : Center(
                      child: CircularProgressIndicator(
                        color: context.accentColor,
                      ),
                    ).expand(),
            ],
          ),
        ),
      ),
    );
  }
}
