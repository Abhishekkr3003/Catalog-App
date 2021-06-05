import 'package:flutter_catalog/models/Cart.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter_catalog/models/userData.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  late CatalogModel catalog;
  late CartModel cart;
  List<Item>? items;
  late UserDetails userInfo;

  MyStore() {
    catalog = CatalogModel();
    cart = CartModel();
    cart.catalog = catalog;
    userInfo =UserDetails();
  }
}
