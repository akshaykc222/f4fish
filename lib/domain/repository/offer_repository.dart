import 'package:grocery_app/domain/entity/offer_entity.dart';

abstract class OfferRepository{
  Future<List<OfferEntity>> getOffer();
}