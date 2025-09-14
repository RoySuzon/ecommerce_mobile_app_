import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/app/core/route/app_route.dart';
import 'package:ecommerce_app/app/core/storage/secure_storage.dart';
import 'package:ecommerce_app/app/di/injector.dart' as di;
import 'package:flutter/widgets.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> bootstrap(
  FutureOr<Widget> Function(bool isLogin) builder, {
  required String baseUrl,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(
    baseUrl: baseUrl,
    onUnauthenticated: () {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        AppRouter.dashboardRoute,
        (route) => false,
      );
    },
  );

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  var login = await isLoggedIn();

  runApp(await builder(!login));
}

Future<bool> isLoggedIn() async {
  final storage = di.sl<SecureStorage>();
  final token = await storage
      .readAccessToken(); // Adjust based on your SecureStorage API
  return token != null && token.isNotEmpty;
}
