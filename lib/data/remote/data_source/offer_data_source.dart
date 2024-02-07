import 'package:grocery_app/core/api_provider.dart';
import 'package:grocery_app/data/remote/model/offer_model.dart';
import 'package:grocery_app/data/remote/routes.dart';
import 'package:grocery_app/domain/entity/offer_entity.dart';

abstract class OfferRemoteDataSource{
  Future<List<OfferEntity>> getOffers();
  
}
class OfferRemoteDataSourceImpl extends OfferRemoteDataSource{
  final ApiProvider apiProvider;

  OfferRemoteDataSourceImpl(this.apiProvider);

  @override
  Future<List<OfferEntity>> getOffers() async{
   final data = await apiProvider.get(AppRemoteRoutes.offers);
   return List<OfferEntity>.from(data['data'].map((x)=>OfferModel.fromJson(x)));
  }
  
}