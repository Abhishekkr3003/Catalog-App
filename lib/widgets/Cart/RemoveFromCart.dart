import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/Cart.dart';
import '../../models/catalog.dart';
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
    return InkWell(
      onLongPress: () => Fluttertoast.showToast(msg: "Remove from cart"),
      onTap: () {
        RemoveMutation(item);
      },
      child: Icon(
        CupertinoIcons.cart_badge_minus,
        color: context.primaryColor,
        size: 40,
      ),
      //fixedSize: MaterialStateProperty.all(value)
    );
  }
}
