import 'package:grocery_app/data/remote/model/payment_model.dart';

class OrderCreateModel {
  OrderCreateModel(
      {required this.cart,
      required this.address,
      required this.paymentRef,
      required this.status,
      required this.region,
      required this.timeSlot,
      this.comments});

  int cart;
  int address;
  PaymentModel paymentRef;
  String status;
  int region;
  int timeSlot;
  String? comments;
  factory OrderCreateModel.fromJson(Map<String, dynamic> json) =>
      OrderCreateModel(
          cart: json["cart"],
          address: json["address"],
          paymentRef: PaymentModel.fromJson(json["payment_ref"]),
          status: json["status"],
          region: json["region"],
          comments: json["comments"],
          timeSlot: 1);

  Map<String, dynamic> toJson() => {
        "cart": cart,
        "address": address,
        "slot": timeSlot,
        "payment_ref": paymentRef.toJson(),
        "status": status,
        "region": region,
        "comments": comments
      };
}
