import 'package:grocery_app/domain/entity/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  PaymentModel({
    required this.id,
    required this.type,
    required this.status,
    required this.transactionId,
    required this.orderAmount,
    this.createdDate,
  }) : super(
            id: id,
            type: type,
            status: status,
            transactionId: transactionId,
            orderAmount: orderAmount,
            createdDate: createdDate);

  int? id;
  String type;
  String status;
  String transactionId;
  double orderAmount;
  DateTime? createdDate;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        type: json["type"],
        status: json["status"],
        transactionId: json["transaction_id"],
        orderAmount: json["order_amount"].toDouble(),
        createdDate: DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "status": status,
        "transaction_id": transactionId,
        "order_amount": orderAmount,
        "created_date": createdDate?.toIso8601String(),
      };
}
