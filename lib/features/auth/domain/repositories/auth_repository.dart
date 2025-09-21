import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<String, UserCredentials>> login(String email, String password);
  Future<Either<String, UserCredentials>> signup(String email, String password);
  Future<Either<String, Map<String, dynamic>>> logout();
}
