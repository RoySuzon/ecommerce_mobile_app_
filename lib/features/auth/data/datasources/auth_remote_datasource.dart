import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signup(String email, String password);
}

// Mock Implementation (replace with Firebase or API)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserEntity> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@mail.com' && password == '123456') {
      return UserEntity(id: '1', email: email);
    }
    throw Exception('Invalid credentials');
  }

  @override
  Future<UserEntity> signup(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return UserEntity(id: '2', email: email);
  }
}
