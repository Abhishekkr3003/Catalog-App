// import 'package:flutter/material.dart';
// import 'package:flutter_catalog/models/Cart.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CartListTile extends StatelessWidget {
//   final int index;
//   final CartModel _cartModel;
//   CartListTile(this.index, this._cartModel);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(Icons.done_outline_sharp),
//       title: _cartModel.items[index].name.text.make(),
//       trailing: InkWell(
//           onTap: () {
//             RemoveMutation(_cartModel.items[index]);
//           },
//           child: Icon(Icons.remove_circle_outlined)),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/Cart.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';
import 'CartProductImage.dart';
import 'CartProductInfo.dart';

class CartListTile extends StatelessWidget {
  final Item item;
  final CartModel _cartModel;
  CartListTile(this.item, this._cartModel);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(item.id.toString()),
            child: CartProductImage(image: item.image),
          ),
          CartProductInfo(item: item),
        ],
      ).expand(),
    ).color(context.canvasColor).rounded.square(130).make().pOnly(right: 20);
  }
}
