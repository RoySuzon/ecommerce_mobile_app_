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
    ..registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));
}
