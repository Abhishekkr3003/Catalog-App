import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      //shape: StadiumBorder(),
      //borderOnForeground: true,
      child: ListTile(
        onTap: () => Fluttertoast.showToast(msg: "${item.name}"),
        contentPadding: EdgeInsets.all(10),
        leading: SizedBox(
          height: 50.0,
          width: 50.0,
          child: Image.network(item.image),
        ),
        title: Text(
          item.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item.desc),
        trailing: Text(
          "\$${item.price}",
          textScaleFactor: 1.2,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
