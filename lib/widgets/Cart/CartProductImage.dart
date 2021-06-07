import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartProductImage extends StatelessWidget {
  final String image;

  const CartProductImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image)
        .box
        .rounded
        .color(context.theme.indicatorColor)
        .p8
        .make()
        .p12()
        .wOneForth(context)
        .hFull(context);
  }
}
