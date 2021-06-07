import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import 'package:flutter_catalog/models/userData.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get email => _auth.currentUser!.email;
  loadData() async {
    print("Email: " + email.toString());
    String cloudIp = "api-cataloap.herokuapp.com";
    try {
      var client = HttpClient();
      await client
          .get(cloudIp, 80, "/getUser/" + email.toString())
          .then((HttpClientRequest request) {
        return request.close();
      }).then((HttpClientResponse response) {
        response.transform(utf8.decoder).listen((contents) {
          var _response = jsonDecode(contents) as List;
          print(_response);
          (VxState.store as MyStore).userInfo =
              UserDetails.fromMap(_response[0]);
          print((VxState.store as MyStore).userInfo.dpURL);
        });
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> onTapFuntions(String option) async {
    if (option == 'Cart') {
      Navigator.pushNamed(context, MyRoutes.cartPage);
    } else if (option == 'Donation') {
      Fluttertoast.showToast(msg: "Not available");
    } else if (option == 'Add Product') {
      Navigator.pushNamed(context, MyRoutes.sellItemPage);
    } else if (option == 'Favorites') {
      Fluttertoast.showToast(msg: "Not available");
    } else if (option == 'Messages') {
      Fluttertoast.showToast(msg: "Not available");
    } else if (option == 'Profile') {
      await loadData();
      Navigator.pushNamed(context, MyRoutes.profilePage);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map> drawerItems = [
      {'icon': FontAwesomeIcons.cartArrowDown, 'title': 'Cart'},
      {'icon': FontAwesomeIcons.coffee, 'title': 'Donation'},
      {'icon': FontAwesomeIcons.plus, 'title': 'Add Product'},
      {'icon': FontAwesomeIcons.solidHeart, 'title': 'Favorites'},
      {'icon': FontAwesomeIcons.solidCommentAlt, 'title': 'Messages'},
      {'icon': FontAwesomeIcons.userAlt, 'title': 'Profile'},
    ];
    return Container(
      color: context.theme.backgroundColor,
      padding: EdgeInsets.only(top: 50, bottom: 40, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Abhishek Kumar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text('Active Status',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ],
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(),
            ],
          ),
          Column(
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: drawerItems
                .map((element) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () => onTapFuntions(element['title']),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              element['title'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              element['icon'],
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Settings',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async => await FirebaseAuth.instance.signOut(),
                child: Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
