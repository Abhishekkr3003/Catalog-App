import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Catalog App".text.xl4.color(MyThemes.darkblue).bold.make(),
            InkWell(
              onTap: () => Navigator.pushNamed(context, MyRoutes.cartPage),
              child: Icon(
                CupertinoIcons.cart,
                size: 40,
              ),
            )
          ],
        ),
        "Trending".text.xl2.bold.make(),
      ],
    );
  }
}
