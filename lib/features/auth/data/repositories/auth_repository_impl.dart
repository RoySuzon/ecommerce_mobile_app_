import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<String, UserCredentials>> login(
    String email,
    String password,
  ) async => remote.login(email, password);

  @override
  Future<Either<String, UserCredentials>> signup(
    String email,
    String password,
  ) async => remote.signup(email, password);

  @override
  Future<String> logout() => remote.logout();
}
