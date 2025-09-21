import 'package:fpdart/fpdart.dart';

import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  Future<Either<String, Map<String, dynamic>>> call() async =>
      repository.logout();
}
