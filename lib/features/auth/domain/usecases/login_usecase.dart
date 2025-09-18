import 'package:ecommerce_app/app/core/storage/secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Either<String, UserEntity>> call(String email, String password) async {
    if (!email.contains('@')) {
      return Future.value(const Left('Email is not vailid'));
      // throw Exception('Somemthing going wrong');
    }
    final res = await repository.login(email, password);
    return res.fold(
      (l) {
        return Left(l);
      },
      (r) async {
        await SecureStorage().saveAccessToken(r.token);
        return Right(r.user);
      },
    );
  }
}
