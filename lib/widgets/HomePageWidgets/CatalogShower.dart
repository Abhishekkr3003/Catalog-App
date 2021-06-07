import 'package:flutter/material.dart';
import '../../Core/Store.dart';
import '../../models/catalog.dart';
import '../../pages/ProductDetails.dart';
import 'listItemWidget.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogShower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyStore store = VxState.store;
    return VxBuilder(
      mutations: {SearchMutation},
      builder: (context, _, __) => ListView.builder(
        shrinkWrap: true,
        itemCount: store.items!.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: ListItemWidget(item: store.items![index]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetails(item: store.items![index], index: index),
              ),
            ),
          );
        },
      ),
    );
  }
}
