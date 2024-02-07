import '../../../domain/entity/offer_entity.dart';

class OfferModel extends OfferEntity {
  OfferModel(
      {required int id,
      required String offerName,
      required String offerCode,
      required String offerImage,
      required DateTime expiry})
      : super(
            id: id,
            offerName: offerName,
            offerCode: offerCode,
            offerImage: offerImage,
            expiry: expiry);

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        offerName: json["offer_name"],
        offerCode: json["offer_code"],
        offerImage: json["offer_image"],
        expiry: DateTime.parse(json["expiry"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "offer_name": offerName,
        "offer_code": offerCode,
        "offer_image": offerImage,
        "expiry":
            "${expiry.year.toString().padLeft(4, '0')}-${expiry.month.toString().padLeft(2, '0')}-${expiry.day.toString().padLeft(2, '0')}",
      };
}
