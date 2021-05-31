import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool iAgree = true;
  bool forAnimation = false;

  void moveToHome() async {
    //await Future.delayed(Duration(seconds: 1));
    await Navigator.pushNamed(context, MyRoutes.homePage);
    setState(() {
      forAnimation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Sign Up".text.color(context.accentColor).xl5.bold.make(),
                "Create your account"
                    .text
                    .color(context.primaryColor)
                    .xl2
                    .make(),
                20.heightBox,
                CupertinoFormSection(
                  backgroundColor: Colors.transparent,
                  header: "Personal Details".text.make(),
                  children: [
                    CupertinoFormRow(
                      //padding: EdgeInsets.only(left: 0),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter name",
                        prefix: "Name".text.make(),
                        padding: EdgeInsets.only(left: 0),
                      ),
                    ),
                    CupertinoFormRow(
                      //padding: EdgeInsets.only(left: 0),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter Email",
                        prefix: "Email".text.make(),
                        padding: EdgeInsets.only(left: 0),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    )
                  ],
                ),
                CupertinoFormSection(
                  backgroundColor: Colors.transparent,
                  header: "User Details".text.make(),
                  children: [
                    CupertinoFormRow(
                      //padding: EdgeInsets.only(left: 0),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter username",
                        prefix: "Username".text.make(),
                        padding: EdgeInsets.only(left: 0),
                      ),
                    ),
                    CupertinoFormRow(
                      //padding: EdgeInsets.only(left: 0),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter Password",
                        obscureText: true,
                        prefix: "Password".text.make(),
                        padding: EdgeInsets.only(left: 0),
                      ),
                    ),
                    CupertinoFormRow(
                      //padding: EdgeInsets.only(left: 0),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter Password",
                        //placeholderStyle: TextStyle(fontSize: 12),
                        obscureText: true,
                        prefix: "Confirm Password".text.make(),
                        padding: EdgeInsets.only(left: 0),
                      ),
                    )
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
                30.heightBox,
                Center(
                  child: Material(
                    color: context.theme.buttonColor,
                    borderRadius: BorderRadius.circular(forAnimation ? 50 : 50),
                    child: InkWell(
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
                                Icons.chevron_right_sharp,
                                size: 50,
                                color: Colors.white,
                              ),
                        width: forAnimation ? 50 : 50,
                        height: 50,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
