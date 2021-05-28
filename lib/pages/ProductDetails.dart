import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatelessWidget {
  final Item item;

  const ProductDetails({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: MyThemes.creamColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: Key(item.id.toString()),
              child: Image.network(item.image),
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
                          .color(MyThemes.darkblue)
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
                  color: Colors.white,
                ),
                height: 30,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        buttonPadding: Vx.mH0,
        children: [
          "\$${item.price}".text.xl3.rose900.bold.make(),
          ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(msg: item.name);
            },
            child: Icon(
              CupertinoIcons.cart_badge_plus,
              color: MyThemes.creamColor,
              size: 20,
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyThemes.darkblue),
              shape: MaterialStateProperty.all(StadiumBorder()),
              //fixedSize: MaterialStateProperty.all(value)
            ),
          ).wh(100, 50),
        ],
      ).p12(),
    );
  }
}
