import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity> login(String email, String password) {
    return remote.login(email, password);
  }

  @override
  Future<UserEntity> signup(String email, String password) {
    return remote.signup(email, password);
  }
}
