import 'package:flutter_catalog/Core/Store.dart';
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

  num get discount => 0;
  num get deliveryCharge => 0;
  num get grandTotal => totalPrice - discount + deliveryCharge;
}

class AddMutation extends VxMutation<MyStore> {
  final Item item;

  AddMutation(this.item);
  @override
  perform() {
    store!.cart._itemIds.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Item item;

  RemoveMutation(this.item);
  @override
  perform() {
    store!.cart._itemIds.remove(item.id);
  }
}
