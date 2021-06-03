import 'dart:collection';
import 'dart:convert';

import 'package:flutter_catalog/Core/Store.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogModel {
  static List<Item>? items;

  Item getById(int id) =>
      items!.firstWhere((item) => item.id == id, orElse: null);

  Item getByPos(int pos) => items![pos];

  //static final dummyItems = List.generate(20, (index) => item[0]);
}

class Item {
  final int id;
  final String name;
  final String desc;
  final String category;
  final String image;
  final num price;

  Item({
    required this.id,
    required this.name,
    required this.desc,
    required this.category,
    required this.image,
    required this.price,
  });

  Item copyWith({
    int? id,
    String? name,
    String? desc,
    String? category,
    String? image,
    num? price,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      category: category ?? this.category,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'color': category,
      'image': image,
      'price': price,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['title'],
      desc: map['description'],
      category: map['category'],
      image: map['image'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc, color: $category, image: $image, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.id == id &&
        other.name == name &&
        other.desc == desc &&
        other.category == category&&
        other.image == image &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        category.hashCode ^
        image.hashCode ^
        price.hashCode;
  }
}

class SearchMutation extends VxMutation<MyStore> {
  final String query;

  SearchMutation(this.query);
  @override
  perform() {
    store!.items = query.length >= 1
        ? CatalogModel.items!
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList()
        : CatalogModel.items;
  }
}
