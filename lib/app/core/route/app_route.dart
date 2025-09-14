import 'package:ecommerce_app/features/auth/presentations/auth_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String productsRoute = '/products';
  static const String productDetailsRoute = '/product-details';
  static const String categoryRoute = '/category';
  static const String expensesRoute = '/expenses';
  static const String reportsRoute = '/reports';
  static const String settingsRoute = '/settings';
  static const String homeRoute = '/home';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
        );
      case dashboardRoute:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Dashboard Screen'),
            ),
          ),
        );
    }
    return null;
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('This is the $title page.')),
    );
  }
}
