import 'package:ecommerce_app/app/core/route/app_route.dart';
import 'package:ecommerce_app/bootstrap.dart';
import 'package:ecommerce_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final bool login;
  const App({super.key, this.login = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: navigatorKey,
      initialRoute: login ? AppRouter.dashboardRoute : AppRouter.loginRoute,
      onGenerateRoute: AppRouter.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const ErrorPage(message: 'Page not found!'),
      ),
    );
  }
}
