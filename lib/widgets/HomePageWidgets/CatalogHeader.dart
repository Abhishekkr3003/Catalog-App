import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
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
            "Catalog App".text.xl4.color(context.accentColor).bold.make(),
            SizedBox(
              height: 50,
              width: 50,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, MyRoutes.cartPage),
                child:
                    //     Image(
                    //       image: AssetImage(
                    //         "assets/Icons/shopping-cart.png",
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Icon(
                  CupertinoIcons.cart,
                  size: 50,
                  color: context.theme.appBarTheme.actionsIconTheme!.color,
                ),
              ),
            )
          ],
        ),
        "Trending".text.color(context.primaryColor).xl2.bold.make(),
      ],
    );
  }
}
