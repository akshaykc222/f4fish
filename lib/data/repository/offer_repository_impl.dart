import 'package:grocery_app/data/remote/data_source/offer_data_source.dart';
import 'package:grocery_app/domain/entity/offer_entity.dart';
import 'package:grocery_app/domain/repository/offer_repository.dart';

class OfferRepositoryImpl extends OfferRepository{
  final OfferRemoteDataSource dataSource;

  OfferRepositoryImpl(this.dataSource);

  @override
  Future<List<OfferEntity>> getOffer() {
    return dataSource.getOffers();
  }

}