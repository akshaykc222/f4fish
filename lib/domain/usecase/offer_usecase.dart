import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/offer_entity.dart';
import 'package:grocery_app/domain/repository/offer_repository.dart';

class OfferUserCase extends UseCase<List<OfferEntity>,NoParams>{
  final OfferRepository repository;

  OfferUserCase(this.repository);

  @override
  Future<List<OfferEntity>> call(NoParams params) {
    return repository.getOffer();
  }

}