// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageSelector extends StatefulWidget {
//   // ImageSelector({Key key}) : super(key: key);

//   @override
//   _ImageSelectorState createState() => _ImageSelectorState();
// }

// class _ImageSelectorState extends State<ImageSelector> {
//   static late File selectedImage;
//   final ImagePicker _picker = ImagePicker();
//   bool imageAvlb = false;


//    Future<String> uploadImage(File file) async {
//     Response response;
//     String fileName = file.path.split('/').last;
//     FormData formData = FormData.fromMap({
//       "image": await MultipartFile.fromFile(file.path, filename: fileName),
//     });
//     response = await Dio().post("http://65.0.21.216/uploaduserImage/1", data: formData);
//     return response.data;
//   }

//   _imgFromCamera() async {
//     PickedFile? pickedFile = await _picker.getImage(
//       source: ImageSource.camera,
//       imageQuality: 50,
//       // maxWidth: 1800,
//       // maxHeight: 1800,
//     );
//     File imageFile = File(pickedFile!.path);
//     setState(() {
//       selectedImage = imageFile;
//       imageAvlb = true;
//     });
//   }

//   _imgFromGallery() async {
//     PickedFile? image = await _picker.getImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//       maxWidth: 1800,
//       maxHeight: 1800,
//     );
//     File imageFile = File(image!.path);

//     setState(() {
//       selectedImage = imageFile;
//       imageAvlb = true;
//     });
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         _imgFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _imgFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   new ListTile(
//                     leading: new Icon(Icons.cancel_sharp),
//                     title: new Text('Remove Image'),
//                     onTap: () {
//                       // _imgFromCamera();
//                       setState(() {
//                         imageAvlb = false;
//                       });

//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: Center(
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 _showPicker(context);
//               },
//               child: imageAvlb
//                   ? CircleAvatar(
//                       backgroundImage: FileImage(
//                         selectedImage,
//                       ),
//                       radius: 50,
//                     )
//                   : CircleAvatar(
//                       child: Icon(FontAwesomeIcons.camera),
//                       radius: 50,
//                     ),
//             ),
//             IconButton(onPressed: ()=>uploadImage(selectedImage), icon: Icon(Icons.done))
//           ],
//         ),
//       )),
//     );
//   }
// }
