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
  final int index;

  const ProductDetails({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var initial;
    var distance;
    final _cart = (VxState.store as MyStore).cart;
    final itemList = (VxState.store as MyStore).items;
    return Scaffold(
      backgroundColor: context.cardColor,
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
      body: GestureDetector(
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
            if (itemList!.length - 1 > index) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(
                      item: itemList[index + 1], index: index + 1),
                ),
              );
            } else {
              Navigator.pop(context);
            }
          } else {
            if (index > 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(
                      item: itemList![index - 1], index: index - 1),
                ),
              );
            } else {
              Navigator.pop(context);
            }
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Hero(
                  tag: Key(item.id.toString()),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      item.image,
                    ),
                  ),
                ).h32(context).p16(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    "${item.name}"
                        .text
                        .bold
                        .xl3
                        .align(TextAlign.center)
                        .color(context.accentColor)
                        .make(),
                    Text(
                      "${item.desc}",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.caption!.merge(
                            TextStyle(fontSize: 15),
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Category:".text.xl.bold.make(),
                        "${item.category.toUpperCase()}".text.xl.make(),
                      ],
                    ).py(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Time Used:".text.xl.bold.make(),
                        "${item.timeUsed}".text.xl.make(),
                      ],
                    ).py(5),
                  ],
                ).pOnly(top: 50, left: 16, right: 16)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: context.canvasColor,
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
