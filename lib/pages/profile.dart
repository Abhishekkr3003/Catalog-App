import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  // const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  @override
  initState() {
    print("building start");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var initial;
    var distance;
    final userinfo = (VxState.store as MyStore).userInfo;
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  userinfo.dpURL.toString(),
                ),
                radius: 150,
              ),
              Container(
                width: context.screenWidth,
                height: context.screenHeight * 0.5,
                child: VxArc(
                  edge: VxEdge.TOP,
                  arcType: VxArcType.CONVEY,
                  child: Container(
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
                          "${userinfo.name}"
                              .text
                              .bold
                              .xl3
                              .align(TextAlign.center)
                              .color(context.accentColor)
                              .make(),
                          "${userinfo.about}"
                              .text
                              .bold
                              .align(TextAlign.center)
                              .color(context.accentColor)
                              .make()
                              .pOnly(bottom: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Email:".text.xl.bold.make(),
                              "${userinfo.email}".text.xl.make(),
                            ],
                          ).py(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Password:".text.xl.bold.make(),
                              "${userinfo.password}".text.xl.make(),
                            ],
                          ).py(10),
                        ],
                      ).pOnly(top: 50, left: 16, right: 16),
                    ),
                    color: context.cardColor,
                  ),
                  height: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
