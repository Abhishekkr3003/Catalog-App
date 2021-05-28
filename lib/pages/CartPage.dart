import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/themes.dart';
import 'package:flutter_catalog/widgets/Cart/CartCalc.dart';
import 'package:flutter_catalog/widgets/Cart/CartItems.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

// class CartPage extends StatefulWidget {
//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.canvasColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: "Cart".text.xl3.bold.make().pOnly(top: 4),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.amber,
//               height: 10000,
//             )
//             //Placeholder().p16().expand(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.xl3.bold.make().pOnly(top: 4),
      ),
      body: Column(
        children: [
          CartItems().expand(),
          Divider(
            color: context.theme.buttonColor,
            thickness: 2,
          ),
          CartCalc(),
        ],
      ),
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: Vx.mH0,
          children: [
            "\$99999".text.xl3.color(context.accentColor).bold.make(),
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(msg: "Coming Soon");
              },
              child: "Order Now".text.color(MyThemes.creamColor).make(),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(context.theme.buttonColor),
                shape: MaterialStateProperty.all(StadiumBorder()),
                //fixedSize: MaterialStateProperty.all(value)
              ),
            ).wh(120, 50),
          ],
        ).p12(),
      ),
    );
  }
}
