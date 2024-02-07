import 'package:grocery_app/domain/entity/ProductEntity.dart';

class QuantityCartModel {
  final int? id;
  int qty;
  final QuantityVariant variant;

  QuantityCartModel({this.id, required this.qty, required this.variant});

  factory QuantityCartModel.fromJson(Map<String, dynamic> json) =>
      QuantityCartModel(
          id: json['id'],
          qty: json['quantity'],
          variant: QuantityVariant.fromJson(json['varient']));
  toJson() => {"id": id, "quantity": qty, "varient": variant.id};
}
