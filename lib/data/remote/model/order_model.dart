import 'package:grocery_app/data/remote/model/payment_model.dart';
import 'package:grocery_app/domain/entity/cart_entity.dart';
import 'package:grocery_app/domain/entity/user_entity.dart';

class OrderModel {
  OrderModel({
    required this.error,
    required this.data,
  });

  bool error;
  List<OrderData> data;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        error: json["error"],
        data: List<OrderData>.from(
            json["data"].map((x) => OrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderData {
  OrderData(
      {required this.status,
      required this.paymentRef,
      required this.cart,
      required this.address,
      required this.createdDate,
      this.id});
  String? id;
  String status;
  PaymentModel paymentRef;
  CartData cart;
  AddressEntity address;
  DateTime createdDate;

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        status: json["status"],
        id: json["order_id"],
        paymentRef: PaymentModel.fromJson(json["payment_ref"]),
        cart: CartData.fromJson(json["cart"]),
        address: AddressEntity.fromJson(json["address"]),
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "payment_ref": paymentRef.toJson(),
        "cart": cart.toJson(),
        "address": address,
        "created_date": createdDate.toIso8601String(),
      };
}
