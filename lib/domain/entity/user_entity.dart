import 'package:equatable/equatable.dart';

class UserEntity {
  UserEntity(
      {required this.id,
      required this.address,
      this.name,
      this.email,
      required this.mobile});

  int? id;
  List<AddressEntity> address;
  dynamic name;
  String mobile;
  String? email;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"],
        address: List<AddressEntity>.from(
            json["address"].map((x) => AddressEntity.fromJson(x))),
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "name": name,
        "email": email,
      };
}

class AddressEntity extends Equatable {
  AddressEntity(
      {this.id,
      this.addressDefault,
      required this.phoneNumber,
      required this.name,
      required this.type,
      required this.address,
      this.lat,
      this.long});

  int? id;
  bool? addressDefault = false;
  String phoneNumber;
  String name;
  String type;
  String address;
  double? lat;
  double? long;

  factory AddressEntity.fromJson(Map<String, dynamic> json) => AddressEntity(
      id: json["id"],
      addressDefault: json["default"],
      phoneNumber: json["phone_number"],
      name: json["name"],
      type: json["type"],
      address: json["address"],
      lat: json["latitude"],
      long: json["longitude"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "default": false,
        "phone_number": phoneNumber,
        "name": name,
        "type": type,
        "address": address,
        "latitude": lat,
        "longitude": long
      };

  @override
  List<Object?> get props => [name, phoneNumber];
}
