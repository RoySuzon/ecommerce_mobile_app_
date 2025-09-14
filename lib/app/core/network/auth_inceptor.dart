import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage storage;
  final void Function()?
  onUnauthenticated; // optional callback to handle 401 (e.g., navigate to login)

  AuthInterceptor({required this.storage, this.onUnauthenticated});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await storage.readAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {}
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;
    if (status == 401) {
      await storage.clear();
      // token invalid/expired — handle as unauthenticated
      if (onUnauthenticated != null) onUnauthenticated!();
      // optionally clear local token here or let repository handle logout
    }
    handler.next(err);
  }
}
