import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import 'package:flutter_catalog/models/Cart.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class RemoveFromCart extends StatelessWidget {
  RemoveFromCart({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    return ElevatedButton(
      onLongPress: () => Fluttertoast.showToast(msg: "Remove from cart"),
      onPressed: () {
        RemoveMutation(item);
      },
      child: Icon(
        CupertinoIcons.cart_badge_minus,
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
