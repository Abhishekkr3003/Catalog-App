import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_catalog/models/Cart.dart';

class CartCalc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartModel _cartModel = (VxState.store as MyStore).cart;
    return Container(
      color: context.cardColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Item Total:".text.xl.make(),
              VxConsumer(
                notifications: {},
                mutations: {RemoveMutation},
                builder: (context, status, obj) {
                  return "\$${_cartModel.totalPrice}".text.xl2.make();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Delivery Charges:".text.xl.make(),
              "\$${_cartModel.deliveryCharge}".text.xl2.make(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Discount:".text.xl.make(),
              "\$${_cartModel.discount}".text.xl2.make(),
            ],
          ),
        ],
      ).p16(),
    );
  }
}
