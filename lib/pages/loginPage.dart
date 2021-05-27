import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool forAnimation = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/mobileLogin.png",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                name == "" ? "Welcome" : "Welcome, $name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter Username", labelText: "Username"),
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter Password", labelText: "Password"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              InkWell(
                onTap: () async {
                  forAnimation = true;
                  setState(() {});

                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pushNamed(context, MyRoutes.homePage);
                },
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
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                  width: forAnimation ? 40 : 80,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade400,
                      borderRadius:
                          BorderRadius.circular(forAnimation ? 40 : 8)),
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
    );
  }
}
