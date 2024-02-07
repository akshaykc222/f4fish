import 'package:grocery_app/domain/entity/ProductEntity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required int id,
      required String name,
      required String description,
      required double marketPrice,
      required double sellingPrice,
      required String? thumbnail,
      required bool preOrder,
      required bool? isFavourite,
      required stock,
      required slug,
      required dateAdded,
      required createDate,
      required updatedDate,
      required region,
      required business,
      required tax,
      required quantityType,
      required colorType,
      required createdUser,
      required sizeType,
      required images,
      required updatedUser})
      : super(
            id: id,
            name: name,
            description: description,
            marketPrice: marketPrice,
            sellingPrice: sellingPrice,
            thumbnail: thumbnail,
            preOrder: preOrder,
            isFavourite: isFavourite,
            images: images,
            stock: stock,
            tax: tax,
            quantityType: quantityType,
            sizeType: null);

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        slug: json['slug'],
        description: json['description'],
        marketPrice: json['market_price'] ?? 0.0,
        sellingPrice: json['selling_price'] ?? 0.0,
        thumbnail: json['thumbnail'],
        stock: json['stock'],
        preOrder: json['pre_order'],
        dateAdded: json['date_added'],
        createDate: json['create_date'],
        updatedDate: json['updated_date'],
        region: json['region'],
        business: json['business'],
        tax: json['tax'],
        quantityType: List<QuantityVariant>.from(
            json['quantity_type'].map((x) => QuantityVariant.fromJson(x))),
        colorType: json['color_type'],
        sizeType: json['size_type'],
        createdUser: json['created_user'],
        updatedUser: json['updated_user'],
        images: json['images'] == null
            ? null
            : List<ImageEntity>.from(
                json['images'].map((x) => ImageEntity.fromJson(x))),
        isFavourite: json['isFavourite'],
      );
}
