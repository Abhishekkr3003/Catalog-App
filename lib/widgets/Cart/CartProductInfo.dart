import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/catalog.dart';
import 'RemoveFromCart.dart';
import 'package:velocity_x/velocity_x.dart';

class CartProductInfo extends StatelessWidget {
  final Item item;

  const CartProductInfo({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              item.name.text.xl.bold
                  .color(context.primaryColor)
                  .make()
                  .expand(),
              RemoveFromCart(item: item) //.pOnly(top: 10),
            ],
          ),
          "\$${item.price}"
              .text
              .xl
              .color(context.primaryColor)
              .make()
              .pOnly(bottom: 4),
        ],
      ).box.make(),
    );
  }
}
