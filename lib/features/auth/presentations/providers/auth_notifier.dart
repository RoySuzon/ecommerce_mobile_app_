import 'package:flutter_riverpod/legacy.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../states/auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthNotifier({required this.loginUseCase, required this.signupUseCase})
    : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await loginUseCase(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signup(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await signupUseCase(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
