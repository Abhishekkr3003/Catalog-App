import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartItems extends StatefulWidget {
  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done_outline_sharp),
        title: "item 1".text.make(),
        trailing: Icon(Icons.remove_circle_outlined),
      ),
    );
  }
}
