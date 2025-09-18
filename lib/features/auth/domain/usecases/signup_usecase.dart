import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;
  SignupUseCase(this.repository);

  Future<Either<String, UserEntity>> call(String email, String password) async {
    if (!email.contains('@')) {
      return Future.value(const Left('Email is not vailid'));
      // throw Exception('Somemthing going wrong');
    }
    final res = await repository.signup(email, password);
    return res.fold(
      (l) {
        // final
        return Left(l);
      },
      (r) {
        return Right(r.user);
      },
    );
  }
}
