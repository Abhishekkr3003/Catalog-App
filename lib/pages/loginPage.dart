import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool forAnimation = false;
  final _formKey = GlobalKey<FormState>();

  void moveToHome() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        forAnimation = true;
      });
      //await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homePage);
      setState(() {
        forAnimation = false;
      });
    }
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
                          decoration: InputDecoration(
                              hintText: "Enter Username",
                              labelText: "Username"),
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
                    height: 40.0,
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
                  )
                  // ElevatedButton(
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
