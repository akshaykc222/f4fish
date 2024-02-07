import 'package:grocery_app/domain/entity/category_entity.dart';
import 'package:grocery_app/domain/entity/offer_entity.dart';

import '../../data/remote/model/home_model.dart';

class HomeEntity {
  List<Category> category;
  List<OfferEntity> offers;
  List<Products> products;

  HomeEntity(
      {required this.category, required this.offers, required this.products});
}
