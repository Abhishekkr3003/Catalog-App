import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  late CatalogModel _catalog;
  final List<int> _itemIds = [];

  CatalogModel get catalogModel => _catalog;

  set catalog(CatalogModel newCatalog) => _catalog = newCatalog;

  List<Item> get items => _itemIds.map((e) => _catalog.getById(e)).toList();

  num get totalPrice =>
      items.fold(0, (previousValue, element) => previousValue + element.price);

  void addToCart(Item item) {
    _itemIds.add(item.id);
  }

  void deleteFromCart(Item item) {
    _itemIds.remove(item.id);
  }
}
