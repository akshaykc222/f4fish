import 'package:grocery_app/data/remote/model/payment_model.dart';

class OrderCreateModel {
  OrderCreateModel(
      {required this.cart,
      required this.address,
      required this.paymentRef,
      required this.status,
      required this.region,
      required this.timeSlot,
      this.id,
      this.comments});

  int? id;
  int cart;
  int address;
  PaymentModel paymentRef;
  String status;
  int region;
  int timeSlot;
  String? comments;
  factory OrderCreateModel.fromJson(Map<String, dynamic> json) =>
      OrderCreateModel(
          id: json['id'],
          cart: json["cart"],
          address: json["address"],
          paymentRef: PaymentModel.fromJson(json["payment_ref"]),
          status: json["status"],
          region: json["region"],
          comments: json["comments"],
          timeSlot: 1);

  Map<String, dynamic> toJson({bool? updatePayment}) {
    Map<String, dynamic> data = {
      "id": id,
      "cart": cart,
      "address": address,
      "slot": timeSlot,
      "status": status,
      "region": region,
      "comments": comments,
      "payment_ref": paymentRef.toJson()
    };
    // if (paymentRef != null) {
    //   data['payment_ref'] = paymentRef!.toJson();
    // }
    // if (updatePayment = true) {
    //   data.remove("cart");
    //   data.remove("address");
    //   data.remove("slot");
    //   data.remove("status");
    //   data.remove("region");
    //   data.remove("comments");
    // }
    return data;
  }
}
