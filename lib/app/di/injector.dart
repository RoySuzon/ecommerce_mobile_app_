import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/core/network/auth_inceptor.dart';
import 'package:ecommerce_app/app/core/network/dio_client.dart';
import 'package:ecommerce_app/app/core/storage/secure_storage.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:ecommerce_app/features/auth/presentations/providers/auth_notifier.dart';
import 'package:ecommerce_app/features/auth/presentations/states/auth_state.dart';
import 'package:ecommerce_app/features/category/data/datasources/category_data_source.dart';
import 'package:ecommerce_app/features/category/data/repository/category_repository_impl.dart';
import 'package:ecommerce_app/features/category/domain/repository/category_repository.dart';
import 'package:ecommerce_app/features/category/domain/usecases/add_category_usecase.dart';
import 'package:ecommerce_app/features/category/domain/usecases/category_get_usecase.dart';
import 'package:ecommerce_app/features/category/presentations/providers/category_notifier.dart';
import 'package:ecommerce_app/features/category/presentations/states/category_state.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> init({
  required String baseUrl,
  void Function()? onUnauthenticated,
}) async {
  // ---------------- Core ----------------
  sl.registerLazySingleton<SecureStorage>(SecureStorage.new);

  // ---------------- API Client ----------------
  final apiClient = ApiClient(
    baseUrl: baseUrl,
    interceptors: [AuthInterceptor(storage: sl<SecureStorage>())],
  );

  sl
    ..registerLazySingleton(() => apiClient.dio)
    // ---------------- Data Sources ----------------
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl<Dio>()),
    )
    // ---------------- Repository ----------------
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
    )
    // ---------------- Use Cases ----------------
    ..registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()))
    ..registerLazySingleton(() => SignupUseCase(sl<AuthRepository>()))
    ..registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()))
    //Data Source
    ..registerLazySingleton<CategoryDataSource>(
      () => CategoryDataSourceImp(dio: sl<Dio>()),
    )
    //Repository
    ..registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl<CategoryDataSource>()),
    )
    //UseCase
    ..registerLazySingleton(() => CategoryGetUsecase(repo: sl()))
    ..registerLazySingleton(() => AddCategoryUsecase(repo: sl()));
}
