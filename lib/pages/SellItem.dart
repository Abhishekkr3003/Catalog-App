import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class SellItem extends StatefulWidget {
  @override
  _SellItemState createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  bool addingProduct = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get email => _auth.currentUser!.email;
  bool iAgree = false;
  bool forAnimation = false;
  final _formKey2 = GlobalKey<FormState>();
  static late File selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool imageAvlb = false;
  late TextEditingController categoryInputController;
  late TextEditingController priceInputController;
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController timeController;
  int id = 0;

  @override
  initState() {
    categoryInputController = new TextEditingController();
    priceInputController = new TextEditingController();
    nameController = new TextEditingController();
    descController = new TextEditingController();
    timeController = new TextEditingController();
    super.initState();
  }

  String cloudIp = "api-cataloap.herokuapp.com";
  Future<int?> getID() async {
    var _response;
    try {
      var client = HttpClient();
      await client
          .get(cloudIp, 80, "/getLastID")
          .then((HttpClientRequest request) {
        return request.close();
      }).then((HttpClientResponse response) {
        response.transform(utf8.decoder).listen((contents) {
          _response = jsonDecode(contents) as List;
          print(_response.runtimeType);
          print(_response);
          id = 0;
          id = _response[0]['id'];
          id += 1;
        });
      });
      return id;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  uploadUserData(String url) async {
    Fluttertoast.showToast(msg: "Upload Data start");
    print("Upload Data start\n");
    var myInt = int.parse(priceInputController.text); // 12345
    final Item item = new Item(
        id: id,
        name: nameController.text,
        desc: descController.text,
        image: imageAvlb
            ? "https://cataloap-product-image.s3.ap-south-1.amazonaws.com/" +
                "$id"
            : "https://cataloap-product-image.s3.ap-south-1.amazonaws.com/noProductImage.png",
        seller: email.toString(),
        timeUsed: timeController.text,
        category: categoryInputController.text,
        price: myInt);
    Response response = await Dio().post(
      url,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: item.toJson(),
    );
    print(response.data);
    Fluttertoast.showToast(msg: response.data);
  }

  uploadImage(File file, String url) async {
    Fluttertoast.showToast(msg: "Upload Image start");
    print("Upload Image start\n");
    Response response;
    print(file.runtimeType);
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    print(url);
    response = await Dio().post(url, data: formData);
    print(response.data);
    Fluttertoast.showToast(msg: response.data);
  }

  void moveToHome() async {
    int _id = 0;
    print("here");
    if (_formKey2.currentState!.validate()) {
      setState(() {
        forAnimation = true;
      });

      setState(() {
        addingProduct = true;
      });
      while (_id == 0) _id = await getID() as int;
      print(_id);
      print("\n");
      print("here also");
      String url =
          "http://api-cataloap.herokuapp.com/uploadProductImage/" + "$_id";
      if (imageAvlb) await uploadImage(selectedImage, url);
      await uploadUserData("http://api-cataloap.herokuapp.com/addproduct");

      Navigator.pop(context);
      setState(() {
        forAnimation = false;
        addingProduct = false;
      });
    }
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
        child: addingProduct
            ? Center(
                child: CircularProgressIndicator(
                  color: context.theme.buttonColor,
                ),
              )
            : Container(
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
                          header: "Product Details".text.make(),
                          children: [
                            CupertinoFormRow(
                              //padding: EdgeInsets.only(left: 0),

                              child: CupertinoTextFormFieldRow(
                                controller: nameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                placeholder: "Product Name",
                                //prefix: "Name".text.make(),
                                padding: EdgeInsets.only(left: 0),
                              ),
                            ),
                            CupertinoFormRow(
                              // helper: "Eg. Men's Fashion"..text.make(),
                              //padding: EdgeInsets.only(left: 0),
                              child: CupertinoTextFormFieldRow(
                                // controller: emailInputController,
                                placeholder:
                                    "Category Eg. Men's Clothing, Household, ...",
                                controller: categoryInputController,
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
                                controller: priceInputController,
                                placeholder: "Price",
                                prefix: "\$".text.coolGray400.make(),
                                padding: EdgeInsets.only(left: 0),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  try {
                                    int.parse(value);
                                  } catch (e) {
                                    return "Enter numerical value only";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            CupertinoFormRow(
                              //padding: EdgeInsets.only(left: 0),
                              child: CupertinoTextFormFieldRow(
                                // controller: emailInputController,
                                placeholder: "How old is this product?",
                                // prefix: "Email".text.make(),
                                padding: EdgeInsets.only(left: 0),
                                controller: timeController,
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
                                controller: descController,
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
