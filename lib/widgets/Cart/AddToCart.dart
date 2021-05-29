import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import 'package:flutter_catalog/models/Cart.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget {
  AddToCart({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    bool thisItemInCart = _cart.items.contains(item);
    return ElevatedButton(
      onLongPress: () => Fluttertoast.showToast(msg: "Add to cart"),
      onPressed: () {
        !thisItemInCart ? AddMutation(item) : RemoveMutation(item);
        !thisItemInCart
            ? Fluttertoast.showToast(msg: "Added to cart")
            : Fluttertoast.showToast(msg: "Removed from cart");
        //setState(() {});
      },
      child: thisItemInCart
          ? ImageIcon(
              AssetImage("assets/Icons/DoneIcon.png"),
              color: Colors.white,
              //size: double.maxFinite,
            )
          : Icon(
              CupertinoIcons.cart_badge_plus,
              color: MyThemes.creamColor,
              size: 20,
            ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(context.theme
            .buttonColor), // ! to remember sometimes context.buttonColor or context.theme.buttonColor
        shape: MaterialStateProperty.all(StadiumBorder()),
        //fixedSize: MaterialStateProperty.all(value)
      ),
    );
  }
}
