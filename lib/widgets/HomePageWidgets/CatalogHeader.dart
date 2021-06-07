import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Core/Store.dart';
import '../../models/Cart.dart';
import '../../utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Cataloap".text.xl4.color(context.accentColor).bold.make(),
            SizedBox(
              height: 50,
              width: 50,
              child: VxBuilder(
                  mutations: {AddMutation, RemoveMutation},
                  builder: (context, x, y) {
                    return InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, MyRoutes.cartPage),
                        child: Icon(
                          CupertinoIcons.cart,
                          size: 50,
                          color:
                              context.theme.appBarTheme.actionsIconTheme!.color,
                        ).badge(
                          size: 20,
                          color: context.theme.buttonColor,
                          count: _cart.items.count(),
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: context.theme.indicatorColor),
                        ));
                  }),
            )
          ],
        ),
      ],
    );
  }
}
