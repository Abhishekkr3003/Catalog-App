import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/catalog.dart';
import '../Cart/AddToCart.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductInfo extends StatelessWidget {
  final Item item;

  const ProductInfo({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.name.text.bold.color(context.primaryColor).make(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              "\$${item.price}".text.color(context.primaryColor).bold.make(),
              SizedBox(width: 50, height: 30, child: AddToCart(item: item)),
            ],
          ).pOnly(right: 12)
        ],
      ),
    );
  }
}
