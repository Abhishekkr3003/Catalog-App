import 'package:flutter/material.dart';
import '../../models/catalog.dart';

class GridItemWidget extends StatelessWidget {
  final Item item;
  const GridItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        header: Container(
          child: Text(item.name),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(),
        ),
        child: Image.network(item.image),
        footer: Text("\$${item.price}"),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //clipBehavior: Clip.antiAlias,
    );
  }
}
