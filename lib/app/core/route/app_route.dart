import 'package:ecommerce_app/app/core/route/common_pages/lost_in_space_page.dart';
import 'package:ecommerce_app/features/auth/presentations/pages/auth_page.dart';
import 'package:ecommerce_app/features/brand/presentations/pages/brand_page.dart';
import 'package:ecommerce_app/features/category/presentations/pages/categrory_page.dart';
import 'package:ecommerce_app/features/home/presentations/pages/home_page.dart';
import 'package:ecommerce_app/features/product/data/presentations/pages/product_create_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String productsRoute = '/products';
  static const String productDetailsRoute = '/product-details';
  static const String categoryRoute = '/category';
  static const String brandRoute = '/brand';
  static const String expensesRoute = '/expenses';
  static const String reportsRoute = '/reports';
  static const String settingsRoute = '/settings';
  static const String homeRoute = '/home';

  static const String addproduct = '/add-product';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
        );
      case dashboardRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case addproduct:
        return MaterialPageRoute(
          builder: (_) => const ProductCreatePage(),
        );
      case categoryRoute:
        return MaterialPageRoute(
          builder: (_) => const CategoryPage(),
        );
      case brandRoute:
        return MaterialPageRoute(
          builder: (_) => const BrandPage(),
        );
      default:
        // Fallback: show error page for unknown routes
        return MaterialPageRoute(
          builder: (_) => const LostInSpacePage(),
        );
    }

    // return
  }
}
