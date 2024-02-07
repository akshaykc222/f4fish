class PaymentEntity {
  PaymentEntity({
    required this.id,
    required this.type,
    required this.status,
    required this.transactionId,
    required this.orderAmount,
    this.createdDate,
  });

  int? id;
  String type;
  String status;
  String transactionId;
  double orderAmount;
  DateTime? createdDate;
}
