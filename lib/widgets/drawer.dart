import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String _currentUserDP =
      "https://cdn.dribbble.com/users/6219808/avatars/normal/data?1603035276";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                accountName: Text("Abhishek Kumar"),
                accountEmail: Text("abhishekkr3003@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(_currentUserDP),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Home",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              leading: Icon(
                CupertinoIcons.home,
              ),
            ),
            ListTile(
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              leading: Icon(
                CupertinoIcons.person,
              ),
            ),
            ListTile(
              title: Text(
                "About us",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              leading: Icon(
                CupertinoIcons.slowmo,
              ),
            ),
            ListTile(
              title: Text(
                "Buy me a coffee!",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              leading: Icon(
                CupertinoIcons.hand_thumbsup,
              ),
            ),
            ListTile(
              title: Text(
                "Logout",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              leading: Icon(
                CupertinoIcons.exclamationmark_shield_fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
