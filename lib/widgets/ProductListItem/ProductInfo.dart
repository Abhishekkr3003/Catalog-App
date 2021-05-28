import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductInfo extends StatelessWidget {
  final Item item;

  const ProductInfo({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          item.name.text.bold.lg.make(),
          Text(
            item.desc,
            style: Theme.of(context).textTheme.caption,
          ),
          Expanded(
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: Vx.mH0,
              children: [
                "\$${item.price}".text.bold.make(),
                SizedBox(
                  width: 50,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      Fluttertoast.showToast(msg: item.name);
                    },
                    child: Icon(
                      CupertinoIcons.cart_badge_plus,
                      color: MyThemes.creamColor,
                      size: 20,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyThemes.darkblue),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      //fixedSize: MaterialStateProperty.all(value)
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ).box.p3.make().px8(),
    );
  }
}