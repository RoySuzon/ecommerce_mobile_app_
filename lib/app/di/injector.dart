import 'package:ecommerce_app/app/core/network/auth_inceptor.dart';
import 'package:ecommerce_app/app/core/network/dio_client.dart';
import 'package:ecommerce_app/app/core/storage/secure_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> init({
  required String baseUrl,
  void Function()? onUnauthenticated,
}) async {
  // Core
  sl.registerLazySingleton(SecureStorage.new);

  // Api client (create without interceptors first)
  final apiClient = ApiClient(
    baseUrl: baseUrl,
    interceptors: [AuthInterceptor(storage: sl<SecureStorage>())],
  );
  sl.registerLazySingleton(() => apiClient.dio);
}
