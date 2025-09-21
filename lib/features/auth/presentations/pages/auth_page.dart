import 'package:ecommerce_app/app/core/route/app_route.dart';
import 'package:ecommerce_app/app/di/injector.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../providers/auth_notifier.dart';
import '../states/auth_state.dart';

enum AuthMode { login, signup }

final authModeProvider = StateProvider<AuthMode>((ref) => AuthMode.login);

// Inject dependencies
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    loginUseCase: sl<LoginUseCase>(),
    signupUseCase: sl<SignupUseCase>(),
  ),
);

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'goutomroy770@gmail.com');
  final passwordController = TextEditingController(text: '111111');
  final confirmPasswordController = TextEditingController(text: '111111');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authMode = ref.watch(authModeProvider);
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      next.whenOrNull(
        authenticated: (user) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome ${user.email}'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.dashboardRoute,
            (route) => false,
          );
        },
        error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.red),
        ),
      );
    });

    void submit() {
      if (formKey.currentState!.validate()) {
        switch (authMode) {
          case AuthMode.login:
            ref
                .read(authProvider.notifier)
                .login(
                  emailController.text,
                  passwordController.text,
                );
          case AuthMode.signup:
            if (passwordController.text != confirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Passwords do not match')),
              );
              return;
            }
            ref
                .read(authProvider.notifier)
                .signup(
                  emailController.text,
                  passwordController.text,
                );
        }
      }
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      authMode == AuthMode.login ? 'Login' : 'Sign Up',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 24),

                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value != null && value.contains('@')
                          ? null
                          : 'Enter a valid email',
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) => value != null && value.length >= 6
                          ? null
                          : 'Password too short',
                    ),
                    const SizedBox(height: 16),

                    if (authMode == AuthMode.signup)
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) =>
                            authMode == AuthMode.signup &&
                                value != passwordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authState.maybeWhen(
                          loading: () => null, // disables the button
                          orElse: () => submit,
                        ),
                        child: authState.maybeWhen(
                          loading: () => const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          orElse: () => Text(
                            authMode == AuthMode.login ? 'Login' : 'Sign Up',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          authMode == AuthMode.login
                              ? 'Don’t have an account?'
                              : 'Already have an account?',
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(authModeProvider.notifier)
                                .state = authMode == AuthMode.login
                                ? AuthMode.signup
                                : AuthMode.login;
                          },
                          child: Text(
                            authMode == AuthMode.login ? 'Sign Up' : 'Login',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
