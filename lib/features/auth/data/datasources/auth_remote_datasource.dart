import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/core/api/api_end_points.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String, UserCredentials>> login(String email, String password);
  Future<Either<String, UserCredentials>> signup(String email, String password);
  Future<String> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.dio);
  final Dio dio;

  @override
  Future<Either<String, UserCredentials>> login(
    String email,
    String password,
  ) async {
    try {
      final res = await dio.post<dynamic>(
        ApiEndPoints.login,
        data: {'email': email, 'password': password},
      );

      if (res.statusCode == 200) {
        final user = res.data['data'] as Map<String, dynamic>;
        return Right(
          UserCredentials.fromMap(user),
        );
      } else {
        return Left(res.data['message']?.toString() ?? 'Login failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response?.data['message']?.toString() ?? 'Server error');
      } else {
        return Left('Network error: ${e.message}');
      }
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  @override
  Future<Either<String, UserCredentials>> signup(
    String email,
    String password,
  ) async {
    try {
      final res = await dio.post<dynamic>(
        ApiEndPoints.register,
        data: {'email': email, 'password': password},
      );

      if (res.statusCode == 201) {
        final user = res.data['data'] as Map<String, dynamic>;
        return Right(
          UserCredentials.fromMap(user),
        );
      } else {
        return Left(res.data['message']?.toString() ?? 'Signup failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response?.data['message']?.toString() ?? 'Server error');
      } else {
        return Left('Network error: ${e.message}');
      }
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  @override
  Future<String> logout() async {
    try {
      final res = await dio.post<dynamic>(ApiEndPoints.logout);

      if (res.statusCode == 200) {
        return res.data['data']['message'].toString();
      } else {
        return res.data['message'].toString();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response?.data['message']?.toString() ?? 'Server error';
      } else {
        return 'Network error: ${e.message}';
      }
    } catch (e) {
      return 'Unexpected error: $e';
    }
  }
}
