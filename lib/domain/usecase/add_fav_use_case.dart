import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';

class AddFavUseCase extends UseCase<void, int> {
  final ProductRepository repository;

  AddFavUseCase(this.repository);

  @override
  Future<void> call(int params) {
    return repository.adFav(id: params);
  }
}
