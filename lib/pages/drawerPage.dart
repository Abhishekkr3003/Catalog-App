import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  void onTapFuntions(String option) {
    if (option == 'Cart') {
      Navigator.pushNamed(context, MyRoutes.cartPage);
    } else if (option == 'Donation') {
      Fluttertoast.showToast(msg: "Not available");
    } else if (option == 'Add Product') {
      Navigator.pushNamed(context, MyRoutes.sellItemPage);
      Fluttertoast.showToast(msg: "Not available");
    } else if (option == 'Favorites') {
      Fluttertoast.showToast(msg: "Not available");
    } else if (option == 'Messages') {
      Fluttertoast.showToast(msg: "Not available");
    } else if (option == 'Profile') {
      Fluttertoast.showToast(msg: "Not available");
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
