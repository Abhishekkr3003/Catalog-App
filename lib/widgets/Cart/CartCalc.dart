import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartCalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Item Total:".text.xl.make(),
            "\$9999".text.xl2.make(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Delivery Charges:".text.xl.make(),
            "\$10".text.xl2.make(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Discount:".text.xl.make(),
            "\$00".text.xl2.make(),
          ],
        ),
      ],
    ).p16();
  }
}
