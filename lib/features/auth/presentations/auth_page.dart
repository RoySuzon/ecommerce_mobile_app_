// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';

// enum AuthMode { login, signup }

// final authModeProvider = StateProvider<AuthMode>((ref) => AuthMode.login);

// class AuthPage extends ConsumerWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authMode = ref.watch(authModeProvider);

//     final formKey = GlobalKey<FormState>();
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final confirmPasswordController = TextEditingController();

//     void submit() {
//       if (formKey.currentState!.validate()) {
//         if (authMode == AuthMode.login) {
//           debugPrint('Login with ${emailController.text}');
//           // TODO: Call login usecase
//         } else {
//           if (passwordController.text != confirmPasswordController.text) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Passwords do not match")),
//             );
//             return;
//           }
//           debugPrint('Signup with ${emailController.text}');
//           // TODO: Call signup usecase
//         }
//       }
//     }

//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Card(
//             elevation: 6,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       authMode == AuthMode.login ? "Login" : "Sign Up",
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                     const SizedBox(height: 24),

//                     // Email
//                     TextFormField(
//                       controller: emailController,
//                       decoration: const InputDecoration(
//                         labelText: "Email",
//                         prefixIcon: Icon(Icons.email),
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) => value != null && value.contains("@")
//                           ? null
//                           : "Enter a valid email",
//                     ),
//                     const SizedBox(height: 16),

//                     // Password
//                     TextFormField(
//                       controller: passwordController,
//                       decoration: const InputDecoration(
//                         labelText: "Password",
//                         prefixIcon: Icon(Icons.lock),
//                         border: OutlineInputBorder(),
//                       ),
//                       obscureText: true,
//                       validator: (value) => value != null && value.length >= 6
//                           ? null
//                           : "Password must be 6+ characters",
//                     ),
//                     const SizedBox(height: 16),

//                     // Confirm Password (only for signup)
//                     if (authMode == AuthMode.signup)
//                       TextFormField(
//                         controller: confirmPasswordController,
//                         decoration: const InputDecoration(
//                           labelText: "Confirm Password",
//                           prefixIcon: Icon(Icons.lock_outline),
//                           border: OutlineInputBorder(),
//                         ),
//                         obscureText: true,
//                         validator: (value) =>
//                             authMode == AuthMode.signup &&
//                                 value != passwordController.text
//                             ? "Passwords do not match"
//                             : null,
//                       ),

//                     const SizedBox(height: 24),

//                     // Submit Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: submit,
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           authMode == AuthMode.login ? "Login" : "Sign Up",
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Switch between login/signup
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           authMode == AuthMode.login
//                               ? "Don’t have an account?"
//                               : "Already have an account?",
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             ref
//                                 .read(authModeProvider.notifier)
//                                 .state = authMode == AuthMode.login
//                                 ? AuthMode.signup
//                                 : AuthMode.login;
//                           },
//                           child: Text(
//                             authMode == AuthMode.login ? "Sign Up" : "Login",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
