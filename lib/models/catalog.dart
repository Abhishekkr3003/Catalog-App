import 'dart:convert';

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
  final String color;
  final String image;
  final num price;

  Item({
    required this.id,
    required this.name,
    required this.desc,
    required this.color,
    required this.image,
    required this.price,
  });

  Item copyWith({
    int? id,
    String? name,
    String? desc,
    String? color,
    String? image,
    num? price,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      color: color ?? this.color,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'color': color,
      'image': image,
      'price': price,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      desc: map['desc'],
      color: map['color'],
      image: map['image'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc, color: $color, image: $image, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.id == id &&
        other.name == name &&
        other.desc == desc &&
        other.color == color &&
        other.image == image &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        color.hashCode ^
        image.hashCode ^
        price.hashCode;
  }
}
