import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/pages/ProductDetails.dart';
import 'package:flutter_catalog/widgets/HomePageWidgets/listItemWidget.dart';

class CatalogShower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.item!.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: ListItemWidget(
            item: CatalogModel.item![index],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                item: CatalogModel.item![index],
              ),
            ),
          ),
        );
      },
    );
  }
}
