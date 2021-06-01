import 'package:firebase_auth/firebase_auth.dart';
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
  final _formKey2 = GlobalKey<FormState>();
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  void moveToHome() async {
    print("here");
    if (_formKey2.currentState!.validate()) {
      setState(() {
        forAnimation = true;
      });
      print("here also");
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailInputController.text,
                password: pwdInputController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
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
            child: Form(
              key: _formKey2,
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
                  CupertinoFormSection(
                    backgroundColor: Colors.transparent,
                    header: "Personal Details".text.make(),
                    children: [
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),

                        child: CupertinoTextFormFieldRow(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username can't be empty";
                            }
                            return null;
                          },
                          placeholder: "Enter name",
                          prefix: "Name".text.make(),
                          padding: EdgeInsets.only(left: 0),
                        ),
                      ),
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          controller: emailInputController,
                          placeholder: "Enter Email",
                          prefix: "Email".text.make(),
                          padding: EdgeInsets.only(left: 0),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email can't be empty";
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
                    header: "User Details".text.make(),
                    children: [
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username can't be empty";
                            }
                            return null;
                          },
                          placeholder: "Enter username",
                          prefix: "Username".text.make(),
                          padding: EdgeInsets.only(left: 0),
                        ),
                      ),
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password can't be empty";
                            } else if (value.length < 6) {
                              return "Password length should be atleast 6.";
                            }
                            return null;
                          },
                          controller: pwdInputController,
                          placeholder: "Enter Password",
                          obscureText: true,
                          prefix: "Password".text.make(),
                          padding: EdgeInsets.only(left: 0),
                        ),
                      ),
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          validator: (value) {
                            if (value!.isEmpty ||
                                value != pwdInputController.text) {
                              return "Confirm Password didn't match with Password provided above";
                            } else if (value.length < 6) {
                              return "Password length should be atleast 6.";
                            }
                            return null;
                          },
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
                                        CupertinoIcons.chevron_right,
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
                  10.heightBox,
                  InkWell(
                      child: "Already have an account?"
                          .text
                          .color(context.theme.buttonColor)
                          .makeCentered(),
                      onTap: () => Navigator.pushReplacementNamed(
                          context, MyRoutes.loginPage)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
