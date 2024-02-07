class OfferEntity {
  OfferEntity({
    required this.id,
    required this.offerName,
    required this.offerCode,
    required this.offerImage,
    required this.expiry,
  });

  int id;
  String offerName;
  String offerCode;
  String offerImage;
  DateTime expiry;
}
