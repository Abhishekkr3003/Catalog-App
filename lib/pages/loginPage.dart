import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool forAnimation = false;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
        email: emailInputController.text,
        password: pwdInputController.text,
      ))
          .user;

      Fluttertoast.showToast(
          msg: "User: ${user!.email} successfully logged in.");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void moveToHome() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        forAnimation = true;
      });
      await _signInWithEmailAndPassword();
      // try {
      //   UserCredential userCredential =
      //       await FirebaseAuth.instance.signInWithEmailAndPassword(
      //     email: emailInputController.text,
      //     password: pwdInputController.text,
      //   ).User;

      // } on FirebaseAuthException catch (e) {
      //   if (e.code == 'user-not-found') {
      //     print('No user found for that email.');
      //   } else if (e.code == 'wrong-password') {
      //     print('Wrong password provided for that user.');
      //   }
      // }
      //await Navigator.pushNamed(context, MyRoutes.homePage);
    }
    setState(() {
      forAnimation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  VxArc(
                    height: 50,
                    child: Image.asset(
                      "assets/images/welcomeImage.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 32.0, right: 32),
                    child: Text(
                      name == "" ? "Welcome" : "Welcome, $name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailInputController,
                          decoration: InputDecoration(
                              hintText: "Enter Email", labelText: "Email"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Username can't be empty";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                        TextFormField(
                          controller: pwdInputController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password can't be empty";
                            } else if (value.length < 6) {
                              return "Password should consist of atleast 6 characters";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    color: context.theme.buttonColor,
                    borderRadius: BorderRadius.circular(forAnimation ? 40 : 8),
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
                            : Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                        width: forAnimation ? 40 : 80,
                        height: 40,
                      ),
                    ),
                  ),
                  10.heightBox,
                  InkWell(
                    child: "Don't have an account?"
                        .text
                        .color(context.theme.buttonColor)
                        .make(),
                    onTap: () async => await Navigator.pushReplacementNamed(
                        context, MyRoutes.signUpPage),
                  ), // ElevatedButton(
                  //     child: Text(
                  //       "Login",
                  //       style: TextStyle(fontSize: 15),
                  //     ),
                  //     style: TextButton.styleFrom(minimumSize: Size(80, 40)),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, MyRoutes.homePage);
                  //     }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
