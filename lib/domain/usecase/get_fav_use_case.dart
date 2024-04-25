import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/entity/ProductEntity.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class GetFavUseCase extends UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository repository;

  GetFavUseCase(this.repository);

  @override
  Future<List<ProductEntity>> call(NoParams params) {
    return repository.getFavorites();
  }
}
