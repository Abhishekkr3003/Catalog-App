import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:flutter_catalog/widgets/HomePageWidgets/CatalogHeader.dart';
import 'package:flutter_catalog/widgets/HomePageWidgets/CatalogShower.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  var toBePrinted = "Android App!";
  String cloudIp = "api-cataloap.herokuapp.com";

  loadData() async {
    //await Future.delayed(Duration(seconds: 5));
    // String catalogJson =
    //     await rootBundle.loadString("assets/files/catalog.json");

    var _response;
    try {
      var client = HttpClient();
      await client
          .get(cloudIp, 80, "/catalog")
          .then((HttpClientRequest request) {
        return request.close();
      }).then((HttpClientResponse response) {
        response.transform(utf8.decoder).listen((contents) {
          _response = jsonDecode(contents) as List;
          print(_response.runtimeType);
          print(_response);
          CatalogModel.items = List.from(_response)
              .map((itemMap) => Item.fromMap(itemMap))
              .toList();
          (VxState.store as MyStore).items = CatalogModel.items;
          setState(() {});
        });
      });
    } catch (e) {
      print(e);
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var initial;
    var distance;
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        initial = details.globalPosition.dx;
      },
      onPanUpdate: (DragUpdateDetails details) {
        distance = details.globalPosition.dx - initial;
      },
      onPanEnd: (DragEndDetails details) {
        initial = 0.0;
        print(distance);
        if (distance < 0)
          setState(() {
            xOffset = -100;
            yOffset = 150;
            scaleFactor = 0.7;
            isDrawerOpen = true;
          });
        else {
          setState(() {
            xOffset = 0;
            yOffset = 0;
            scaleFactor = 1;
            isDrawerOpen = false;
          });
        }
      },
      child: AnimatedContainer(
        //height: double.infinity,
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: Duration(milliseconds: 150),
        decoration: BoxDecoration(
            color: context.canvasColor,
            borderRadius: BorderRadius.circular(isDrawerOpen ? 60 : 0.0)),

        //padding: EdgeInsets.only(left: 16, top: 16, right: 16),
        //color: Colors.white,
        child: GestureDetector(
          onPanDown: (value) async {
            print("hi");
            await loadData();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader().pOnly(left: 20, top: 12, right: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Trending".text.color(context.primaryColor).xl2.bold.make(),
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(FontAwesomeIcons.chevronCircleRight),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            FontAwesomeIcons.ioxhost,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                xOffset = -100;
                                yOffset = 150;
                                scaleFactor = 0.7;
                                isDrawerOpen = true;
                              },
                            );
                          },
                        ),
                ],
              ).pOnly(left: 20, right: 16),
              CupertinoSearchTextField(
                style: TextStyle(
                  color: context.primaryColor,
                ),
                onChanged: (value) {
                  SearchMutation(value);
                },
              ).pOnly(top: 12, left: 20, right: 20),
              20.heightBox,
              (CatalogModel.items != null && CatalogModel.items!.length > 0)
                  ? CatalogShower().pOnly(left: 20, right: 20).expand()
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
