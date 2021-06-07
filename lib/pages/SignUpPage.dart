import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_catalog/models/userData.dart';
import 'package:flutter_catalog/Core/Store.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool iAgree = false;
  bool forAnimation = false;
  final _formKey2 = GlobalKey<FormState>();
  static late File selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool imageAvlb = false;
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;
  late TextEditingController nameController;
  late TextEditingController aboutController;
  late TextEditingController cnfpwdController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    nameController = new TextEditingController();
    aboutController = new TextEditingController();
    cnfpwdController = new TextEditingController();
    super.initState();
  }

  uploadUserData(String url) async {
    final UserDetails userDetails = new UserDetails(
        name: nameController.text,
        about: aboutController.text,
        dpURL: imageAvlb
            ? "https://cataloap-user-image.s3.ap-south-1.amazonaws.com/" +
                emailInputController.text
            : "https://cataloap-user-image.s3.ap-south-1.amazonaws.com/NoDP",
        email: emailInputController.text,
        password: pwdInputController.text);
    (VxState.store as MyStore).userInfo = userDetails;
    Response response = await Dio().post(
      url,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: userDetails.toJson(),
    );
    print(response.data);
  }

  Future<String> uploadImage(File file, String url) async {
    Response response;
    print(file.runtimeType);
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    print(url);
    response = await Dio().post(url, data: formData);
    return response.data;
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
      String url = "http://api-cataloap.herokuapp.com/uploaduserImage/" +
          emailInputController.text;
      if (imageAvlb) await uploadImage(selectedImage, url);
      await uploadUserData("http://api-cataloap.herokuapp.com/addUser");
      print("logged");
    }

    setState(() {
      forAnimation = false;
    });
  }

  _imgFromCamera() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      // maxWidth: 1800,
      // maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        selectedImage = imageFile;
        imageAvlb = true;
      });
    }
  }

  _imgFromGallery() async {
    PickedFile? image = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (image != null) {
      File imageFile = File(image.path);

      setState(() {
        selectedImage = imageFile;
        imageAvlb = true;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.cancel_sharp),
                    title: new Text('Remove Image'),
                    onTap: () {
                      // _imgFromCamera();
                      setState(() {
                        imageAvlb = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
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
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: imageAvlb
                          ? CircleAvatar(
                              backgroundImage: FileImage(
                                selectedImage,
                              ),
                              radius: 50,
                            )
                          : CircleAvatar(
                              child: Icon(FontAwesomeIcons.camera),
                              radius: 50,
                            ),
                    ),
                  ).pOnly(top: 20, bottom: 20),
                  CupertinoFormSection(
                    backgroundColor: Colors.transparent,
                    header: "Personal Details".text.make(),
                    children: [
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name can't be empty";
                            }
                            return null;
                          },
                          placeholder: "Name",
                          // prefix: "Name".text.make(),
                          padding: EdgeInsets.only(left: 0),
                        ),
                      ),
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          controller: aboutController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "About can't be empty";
                            }
                            return null;
                          },
                          placeholder: "About",
                          maxLines: 3,
                          maxLength: 100,
                          // prefix: "Username".text.make(),
                          padding: EdgeInsets.only(left: 0),
                        ),
                      ),
                    ],
                  ),
                  20.heightBox,
                  CupertinoFormSection(
                    backgroundColor: Colors.transparent,
                    header: "Login Details".text.make(),
                    children: [
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          controller: emailInputController,
                          placeholder: "Email",
                          // prefix: "Email".text.make(),
                          padding: EdgeInsets.only(left: 0),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email can't be empty";
                            }
                            return null;
                          },
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
                          placeholder: "Password",
                          obscureText: true,
                          // prefix: "Password".text.make(),
                          padding: EdgeInsets.only(left: 0),
                        ),
                      ),
                      CupertinoFormRow(
                        //padding: EdgeInsets.only(left: 0),
                        child: CupertinoTextFormFieldRow(
                          controller: cnfpwdController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required";
                            } else if (value.length < 6) {
                              return "Password length should be atleast 6.";
                            } else if (pwdInputController.text !=
                                cnfpwdController.text) {
                              return "Confirm password should be same as password";
                            }
                            return null;
                          },
                          placeholder: "Confirm Password",
                          //placeholderStyle: TextStyle(fontSize: 12),
                          obscureText: true,
                          // prefix: "Confirm Password".text.make(),
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
