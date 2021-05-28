import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl4.color(MyThemes.darkblue).bold.make(),
        "Trending".text.xl2.bold.make(),
      ],
    );
  }
}