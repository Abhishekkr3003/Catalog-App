import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/widgets/Cart/AddToCart.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatelessWidget {
  final Item item;

  const ProductDetails({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(item.id.toString()),
              child: Image.network(
                item.image,
              ),
            ).h32(context).p16(),
            Expanded(
              child: VxArc(
                edge: VxEdge.TOP,
                arcType: VxArcType.CONVEY,
                child: Container(
                  width: context.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      "${item.name}"
                          .text
                          .bold
                          .xl3
                          .color(context.accentColor)
                          .make(),
                      Text(
                        "${item.desc}",
                        style: Theme.of(context).textTheme.caption!.merge(
                              TextStyle(fontSize: 15),
                            ),
                      ),
                      "At ea et ipsum et stet takimata amet no sanctus accusam. Takimata magna consetetur sed sit ipsum est. Dolor amet eirmod est gubergren sanctus clita takimata. Kasd erat tempor et."
                          .text
                          .justify
                          .make()
                          .expand(),
                    ],
                  ).pOnly(top: 40, left: 12, right: 12),
                  color: context.cardColor,
                ),
                height: 30,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: Vx.mH0,
          children: [
            "\$${item.price}".text.xl3.color(context.accentColor).bold.make(),
            AddToCart(item: item),
          ],
        ).p12(),
      ),
    );
  }
}
