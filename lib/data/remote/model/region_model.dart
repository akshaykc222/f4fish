class RegionModel {
  RegionModel({
    required this.id,
    required this.name,
    required this.pinCode,
    required this.deliveryCharge,
  });

  int id;
  String name;
  String pinCode;
  double deliveryCharge;

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        id: json["id"],
        name: json["name"],
        pinCode: json["pin_code"],
        deliveryCharge: json["delivery_charge"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pin_code": pinCode,
        "delivery_charge": deliveryCharge,
      };
}
