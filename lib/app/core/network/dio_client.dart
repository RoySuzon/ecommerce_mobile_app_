import 'package:dio/dio.dart';

class ApiClient {
  factory ApiClient({
    required String baseUrl,
    List<Interceptor>? interceptors,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    if (interceptors != null) dio.interceptors.addAll(interceptors);

    return ApiClient._(dio);
  }
  final Dio dio;

  ApiClient._(this.dio);
}




/* 

import 'package:dio/dio.dart';

/// Custom exceptions for better error handling
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (statusCode: $statusCode)';
}

class ApiClient {
  factory ApiClient({
    required String baseUrl,
    List<Interceptor>? interceptors,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
        // validateStatus: (status) {
        //   // ✅ Treat <500 as valid; 500+ are server errors
        //   return status != null && status < 500;
        // },
      ),
    );

    // ✅ Logging interceptor (debug only)
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
    );

    // ✅ Custom interceptors (e.g., auth)
    if (interceptors != null) dio.interceptors.addAll(interceptors);

    return ApiClient._(dio);
  }

  final Dio dio;

  ApiClient._(this.dio);

  /// Generic GET request with exception handling
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  /// Generic POST request with exception handling
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  /// Handle valid responses and HTTP errors
  Response<T> _handleResponse<T>(Response<T> response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return response;
    } else {
      throw ApiException(
        response.data.toString(),
        response.statusCode,
      );
    }
  }

  /// Map DioError to our ApiException
  ApiException _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return ApiException('Connection timeout, please try again');
    } else if (error.type == DioExceptionType.badResponse) {
      return ApiException(
        error.response?.data.toString() ?? 'Server error',
        error.response?.statusCode,
      );
    } else if (error.type == DioExceptionType.unknown) {
      return ApiException('No internet connection or unexpected error');
    } else {
      return ApiException(error.message ?? 'Something going wrong!');
    }
  }
}


 */