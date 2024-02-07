import 'package:grocery_app/data/remote/model/offer_model.dart';
import 'package:grocery_app/data/remote/model/product_model.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/entity/category_entity.dart';
import 'package:grocery_app/domain/entity/home_entity.dart';
import 'package:grocery_app/domain/entity/offer_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel(
      {required List<Category> category,
      required List<OfferEntity> offers,
      required List<Products> products})
      : super(category: category, offers: offers, products: products);
  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
      category: List<Category>.from(
          json['category'].map((x) => Category.fromJson(x))),
      offers: List<OfferEntity>.from(
          json['offers'].map((x) => OfferModel.fromJson(x))),
      products: List<Products>.from(
          json['products'].map((x) => Products.fromJson(x))));
}

class Products {
  String? title;
  List<ProductEntity>? data;

  Products({this.title, this.data});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
      title: json['title'],
      data: List<ProductEntity>.from(
          json['data'].map((x) => ProductModel.fromJson(x))));
}
