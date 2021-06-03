import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import 'package:flutter_catalog/models/Cart.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:flutter_catalog/widgets/Cart/AddToCart.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatelessWidget {
  final Item item;

  const ProductDetails({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var initial;
    var distance;
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          SizedBox(
            height: 40,
            width: 40,
            child: VxBuilder(
                mutations: {AddMutation, RemoveMutation},
                builder: (context, x, y) {
                  return InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, MyRoutes.cartPage),
                      child: Icon(
                        CupertinoIcons.cart,
                        size: 40,
                        color:
                            context.theme.appBarTheme.actionsIconTheme!.color,
                      ).badge(
                        size: 20,
                        color: context.theme.buttonColor,
                        count: _cart.items.count(),
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.theme.indicatorColor),
                      ));
                }),
          ).pOnly(right: 20, top: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Hero(
                tag: Key(item.id.toString()),
                child: Image.network(
                  item.image,
                ),
              ).h32(context).p16(),
              VxArc(
                edge: VxEdge.TOP,
                arcType: VxArcType.CONVEY,
                child: Container(
                  width: context.screenWidth,
                  child: GestureDetector(
                    onPanStart: (DragStartDetails details) {
                      initial = details.globalPosition.dx;
                    },
                    onPanUpdate: (DragUpdateDetails details) {
                      distance = details.globalPosition.dx - initial;
                    },
                    onPanEnd: (DragEndDetails details) {
                      initial = 0.0;
                      print(distance);
                      if (distance < 0) {
                        print("Left Gesture");
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        "${item.name}"
                            .text
                            .bold
                            .xl3
                            .align(TextAlign.center)
                            .color(context.accentColor)
                            .make(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Category:".text.xl.bold.make(),
                            "${item.category.toUpperCase()}".text.xl.make(),
                          ],
                        ).py(10),
                        Text(
                          "${item.desc}",
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.caption!.merge(
                                TextStyle(fontSize: 15),
                              ),
                        ),
                        "At taki mata edfas ssssss sssss sssss ssssss sssssssssssssss amet no sanctus accusam. Takimata magna consetetur sed sit ipsum est. Dolor amet eirmod est gubergren sanctus clita takimata. Kasd erat tempor et."
                            .text
                            .justify
                            .make(),
                      ],
                    ).pOnly(top: 50, left: 16, right: 16),
                  ),
                  color: context.cardColor,
                ),
                height: 30,
              )
            ],
          ),
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
