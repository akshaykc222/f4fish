import 'package:equatable/equatable.dart';

class ProductEntity {
  int id;
  String name;
  String? slug;
  String description;
  double marketPrice;
  double sellingPrice;
  String? thumbnail;
  int? stock;
  bool preOrder;
  String? dateAdded;
  String? createDate;
  String? updatedDate;
  int? region;
  int? business;

  int? tax;
  List<QuantityVariant> quantityType;
  int? colorType;
  int? sizeType;
  int? createdUser;
  int? updatedUser;
  List<ImageEntity>? images;
  bool? isFavourite;

  ProductEntity(
      {required this.id,
      required this.name,
      this.slug,
      required this.description,
      required this.marketPrice,
      required this.sellingPrice,
      required this.thumbnail,
      this.stock,
      required this.preOrder,
      this.dateAdded,
      this.createDate,
      this.updatedDate,
      this.region,
      this.business,
      this.tax,
      required this.quantityType,
      this.colorType,
      this.sizeType,
      this.createdUser,
      this.updatedUser,
      this.images,
      required this.isFavourite});
}

class ImageEntity {
  ImageEntity({
    required this.id,
    this.isVedio,
    this.image,
  });

  int id;
  bool? isVedio;
  String? image;

  factory ImageEntity.fromJson(Map<String, dynamic> json) => ImageEntity(
        id: json["id"],
        isVedio: json["is_vedio"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_vedio": isVedio,
        "image": image,
      };
}
/*
class QuantityVariant1 extends Equatable {
  final int id;
  final String variantName;
  final double price;
  final double sellingPrice;

  QuantityVariant(
      {required this.id,
      required this.variantName,
      required this.price,
      required this.sellingPrice});

  factory QuantityVariant.fromJson(Map<String, dynamic> json) =>
      QuantityVariant(
          id: json['id'],
          variantName: json['variant_name'],
          price: json['price'],
          sellingPrice: json['selling_price']);

  @override
  List<Object?> get props => [id, variantName, price];
}*/

class QuantityVariant extends Equatable {
  int? id;
  String? variantName;
  String? variantImage;
  String? sizeName;
  double? price;
  double? sellingPrice;

  QuantityVariant(
      {this.id,
      this.variantName,
      this.variantImage,
      this.sizeName,
      this.price,
      this.sellingPrice});

  factory QuantityVariant.fromJson(Map<String, dynamic> json) =>
      QuantityVariant(
          id: json["id"],
          variantName: json["variant_name"],
          variantImage: json["variant_image"],
          sizeName: json['size_name'],
          price: json['price'],
          sellingPrice: json['selling_price']);

  Future<Map<String, dynamic>> toJson() async => {
        "id": id,
        "variant_name": variantName,
        "size_name": sizeName,
        "price": price,
        "selling_price": sellingPrice
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class SizeVariant {
  int? id;
  String? sizeName;
  double? price;

  SizeVariant({this.id, this.sizeName, this.price});

  SizeVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sizeName = json['size_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size_name'] = this.sizeName;
    data['price'] = this.price;
    return data;
  }
}
