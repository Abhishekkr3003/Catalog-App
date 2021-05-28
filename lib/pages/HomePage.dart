import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widgets/drawer.dart';
// import 'package:flutter_catalog/widgets/listItemWidget.dart';
import 'dart:convert';

import 'package:flutter_catalog/widgets/gridItemWidget.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: (CatalogModel.item != null && CatalogModel.item!.isNotEmpty)
              ? GridView.builder(
                  itemCount: CatalogModel.item!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    final Item item = CatalogModel.item![index];
                    return GridItemWidget(item: item);
                  })
              //  ListView.builder(
              //     itemCount: CatalogModel.item!.length,
              //     itemBuilder: (context, index) {
              //       return ListItemWidget(item: CatalogModel.item![index]);
              //     },
              //   )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
