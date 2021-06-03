import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class SellItem extends StatefulWidget {
  @override
  _SellItemState createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  bool iAgree = true;
  bool forAnimation = false;
  final _formKey2 = GlobalKey<FormState>();
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;

  void moveToHome() async {
    print("here");
    if (_formKey2.currentState!.validate()) {
      setState(() {
        forAnimation = true;
      });
      Fluttertoast.showToast(msg: "Listed to sell");
      Navigator.pop(context);
    }
    setState(() {
      forAnimation = false;
    });
  }

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Container(
          padding: Vx.m20,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(FontAwesomeIcons.chevronLeft)),
                      "Seller's Zone"
                          .text
                          .color(context.accentColor)
                          .xl5
                          .bold
                          .makeCentered(),
                    ],
                  ),
                  "What you want to sell today?"
                      .text
                      .color(context.primaryColor)
                      .xl2
                      .makeCentered(),
                  CupertinoFormSection(
                    backgroundColor: Colors.transparent,
                    header: "Product Details".text.make(),
                    children: [
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),

                        child: CupertinoTextFormFieldRow(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                          placeholder: "Product Title",
                          //prefix: "Name".text.make(),
                          padding: EdgeInsets.only(left: 0),
                        ),
                      ),
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          // controller: emailInputController,
                          placeholder: "Category",
                          // prefix: "Email".text.make(),
                          padding: EdgeInsets.only(left: 0),

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          // controller: emailInputController,
                          placeholder: "Image Link",
                          // prefix: "Email".text.make(),
                          padding: EdgeInsets.only(left: 0),

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      ),
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          // controller: emailInputController,
                          placeholder: "Price",
                          // prefix: "Email".text.make(),
                          padding: EdgeInsets.only(left: 0),

                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  20.heightBox,
                  CupertinoFormSection(
                    backgroundColor: Colors.transparent,
                    header: "Description".text.make(),
                    children: [
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          maxLines: 10,
                          maxLength: 1000,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            }
                            return null;
                          },
                          // placeholder: "Enter username",
                          // prefix: "Username".text.make(),
                          padding: EdgeInsets.only(left: 0),
                        ),
                      ),
                    ],
                  ),
                  CupertinoFormSection(
                    backgroundColor: Colors.transparent,
                    header: "Terms & Conditions".text.make(),
                    children: [
                      CupertinoFormRow(
                        prefix: "I Agree".text.make(),
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoSwitch(
                          activeColor: context.theme.buttonColor,
                          value: iAgree,
                          onChanged: (value) {
                            setState(() {
                              iAgree = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  10.heightBox,
                  Center(
                    child: Material(
                      color: context.theme.buttonColor,
                      borderRadius:
                          BorderRadius.circular(forAnimation ? 50 : 50),
                      child: iAgree
                          ? InkWell(
                              onTap: () => moveToHome(),
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                alignment: Alignment.center,
                                child: forAnimation
                                    ? Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        CupertinoIcons.add,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                width: forAnimation ? 50 : 50,
                                height: 50,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
