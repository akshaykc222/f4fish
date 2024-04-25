import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_app/data/local/data_source/auth_local_datasource.dart';
import 'package:grocery_app/data/remote/data_source/auth_data_source.dart';
import 'package:grocery_app/data/remote/data_source/category_data_source.dart';
import 'package:grocery_app/data/remote/data_source/home_remote_data_source.dart';
import 'package:grocery_app/data/remote/data_source/offer_data_source.dart';
import 'package:grocery_app/data/remote/data_source/products_remote_data_source.dart';
import 'package:grocery_app/data/repository/auth_data_repository_impl.dart';
import 'package:grocery_app/data/repository/auth_local_repository_impl.dart';
import 'package:grocery_app/data/repository/category_data_repository_impl.dart';
import 'package:grocery_app/data/repository/home_repository_impl.dart';
import 'package:grocery_app/data/repository/productRepositoryImpl.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';
import 'package:grocery_app/domain/repository/auth_local_repositary.dart';
import 'package:grocery_app/domain/repository/category_data_repository.dart';
import 'package:grocery_app/domain/repository/home_repoistory.dart';
import 'package:grocery_app/domain/repository/product_repository.dart';
import 'package:grocery_app/domain/usecase/add_address_use_case.dart';
import 'package:grocery_app/domain/usecase/add_cart_use_case.dart';
import 'package:grocery_app/domain/usecase/add_fav_use_case.dart';
import 'package:grocery_app/domain/usecase/delete_cart_use_case.dart';
import 'package:grocery_app/domain/usecase/get_all_locations.dart';
import 'package:grocery_app/domain/usecase/get_cart_use_case.dart';
import 'package:grocery_app/domain/usecase/get_expand_product_usecase.dart';
import 'package:grocery_app/domain/usecase/get_fav_use_case.dart';
import 'package:grocery_app/domain/usecase/get_product_usecase.dart';
import 'package:grocery_app/domain/usecase/get_user_user_case.dart';
import 'package:grocery_app/domain/usecase/home_use_case.dart';
import 'package:grocery_app/domain/usecase/location_use_case.dart';
import 'package:grocery_app/domain/usecase/logout_usecase.dart';
import 'package:grocery_app/domain/usecase/offer_usecase.dart';
import 'package:grocery_app/domain/usecase/order_create_usercase.dart';
import 'package:grocery_app/domain/usecase/order_usercase.dart';

import 'core/api_provider.dart';
import 'domain/usecase/upate_order_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //data source

  sl.registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ProductRemoteDataUseCase>(
      () => ProductRemoteDataUseCaseImpl(sl()));
  sl.registerLazySingleton<OfferRemoteDataSource>(
      () => OfferRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl()));
  //repository
  sl.registerLazySingleton<AuthDataRepository>(
      () => AuthDataRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthLocalRepository>(() => AuthLocalRepositoryImpl(
        sl(),
      ));
  sl.registerLazySingleton<CategoryDataRepository>(
      () => CategoryDataRepositoryImpl(sl()));
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  //usecase
  sl.registerLazySingleton<OfferUserCase>(() => OfferUserCase(sl()));
  sl.registerLazySingleton<HomeUseCase>(() => HomeUseCase(sl()));
  sl.registerLazySingleton<GetProductUseCase>(() => GetProductUseCase(sl()));
  sl.registerLazySingleton<OrderStaffUseCase>(() => OrderStaffUseCase(sl()));
  sl.registerLazySingleton<ProductExpandUseCase>(
      () => ProductExpandUseCase(sl()));
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()));
  sl.registerLazySingleton<AddCartUseCase>(() => AddCartUseCase(sl()));
  sl.registerLazySingleton<GetCartUseCase>(() => GetCartUseCase(sl()));
  sl.registerLazySingleton<DeleteCartUseCase>(() => DeleteCartUseCase(sl()));
  sl.registerLazySingleton<OrderCreateUseCase>(() => OrderCreateUseCase(sl()));
  sl.registerLazySingleton<OrderUseCase>(() => OrderUseCase(sl()));
  sl.registerLazySingleton<UpdateOrderUseCase>(() => UpdateOrderUseCase(sl()));
  sl.registerLazySingleton<SaveLocationUseCase>(
      () => SaveLocationUseCase(sl()));
  sl.registerLazySingleton<GetLocalLocationUseCase>(
      () => GetLocalLocationUseCase(sl()));
  sl.registerLazySingleton<GetAllLocationsUseCase>(
      () => GetAllLocationsUseCase(sl()));
  sl.registerLazySingleton<GetNearestLocation>(() => GetNearestLocation(sl()));
  sl.registerLazySingleton<GetUserUseCaseAddress>(
      () => GetUserUseCaseAddress(sl()));
  sl.registerLazySingleton<AddAddressUseCase>(() => AddAddressUseCase(sl()));
  sl.registerLazySingleton<AddFavUseCase>(() => AddFavUseCase(sl()));
  sl.registerLazySingleton<GetFavUseCase>(() => GetFavUseCase(sl()));
  //core
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());

  await GetStorage.init();
  // sl.registerSingleton(NavigationBarMoksha(sl()));
  // sl.registerLazySingleton<ConnectionInfo>(() => ConnectionInfoImpl(sl()));
  // sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => GetStorage());
}
