import 'package:flutter/material.dart';
import 'package:flutter_catalog/Core/Store.dart';
import '../../models/Cart.dart';
import '../../pages/ProductDetails.dart';
import 'CartListTile.dart';
import 'package:velocity_x/velocity_x.dart';

class CartItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cartModel = (VxState.store as MyStore).cart;
    return _cartModel.items.isEmpty
        ? EmptyCart()
        : ListView.builder(
            itemCount: _cartModel.items.length,
            itemBuilder: (context, index) => InkWell(
              child: CartListTile(_cartModel.items[index], _cartModel),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(
                    item: _cartModel.items[index], index: index
                  ),
                ),
              ),
            ),
          );
  }
}

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.asset(
                "assets/images/EmptyCart.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          "Cart is Empty".text.xl3.makeCentered().p16(),
        ],
      ),
    );
  }
}
