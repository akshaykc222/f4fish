import 'package:equatable/equatable.dart';
import 'package:grocery_app/data/remote/model/product_model.dart';
import 'package:grocery_app/domain/entity/quantity_cart_model.dart';

import '../../presentation/helpers/enums.dart';
import 'ProductEntity.dart';

class CartEntity {
  CartEntity({
    required this.data,
  });

  CartData data;

  factory CartEntity.fromJson(Map<String, dynamic> json) => CartEntity(
        data: CartData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class CartData {
  CartData({
    this.id,
    required this.products,
    required this.total,
    this.isComplete,
    this.date,
  });

  int? id;

  List<CartProduct> products = [];
  double? total;
  bool? isComplete;
  DateTime? date;

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json["id"],
        products: List<CartProduct>.from(
            json["products"].map((x) => CartProduct.fromJson(x))),
        total: json["total"] ?? 0.0,
        isComplete: json["isComplete"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
      };
}

class CartProduct extends Equatable {
  CartProduct({
    this.id,
    required this.price,
    required this.product,
    required this.qtyType,
    required this.productStatus,
    required this.quantity,
    required this.subtotal,
    this.colorType,
  });

  int? id;
  double price;
  ProductEntity product;
  List<QuantityCartModel> qtyType;
  ProductStatus productStatus;
  int quantity;
  double subtotal;
  dynamic colorType;

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["id"],
        price: json["price"].toDouble(),
        product: ProductModel.fromJson(json["product"]),
        qtyType: List<QuantityCartModel>.from(
            json['qty_type'].map((e) => QuantityCartModel.fromJson(e))),
        productStatus: getProductStatusFromJson(json["product_status"]),
        quantity: json["quantity"],
        subtotal: json["subtotal"].toDouble(),
        colorType: json["color_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "product": product.id,
        "qty_type": List<dynamic>.from(qtyType.map((e) => e.toJson())),
        "product_status": productStatus.name,
        "quantity": quantity,
        "subtotal": subtotal,
        "color_type": colorType,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
      ];
}
