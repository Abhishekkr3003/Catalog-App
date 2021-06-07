import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';
import '../ProductListItem/ProductImage.dart';
import '../ProductListItem/ProductInfo.dart';

class ListItemWidget extends StatelessWidget {
  final Item item;

  const ListItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(item.id.toString()),
            child: ProductImage(image: item.image),
          ),
          ProductInfo(item: item),
        ],
      ),
    ).color(context.cardColor).rounded.square(100).make().py4();
  }
}
