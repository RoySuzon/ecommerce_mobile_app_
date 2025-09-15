import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/core/route/app_route.dart';
import 'package:ecommerce_app/app/di/injector.dart';
import 'package:ecommerce_app/bootstrap.dart';
import 'package:ecommerce_app/features/components/generic_dropdown/cubit/dropdown_bloc.dart';
import 'package:ecommerce_app/features/components/generic_dropdown/cubit/dropdown_event.dart';
import 'package:ecommerce_app/features/product/data/datasource/dropdown_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:ecommerce_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final bool login;
  const App({super.key, this.login = false});

  @override
  Widget build(BuildContext context) {
    // 🔹 Generic method to create Bloc
    DropdownBloc<T> createDropdownBloc<T>(Future<List<T>> Function() fetcher) {
      final bloc = DropdownBloc<T>()..add(DropdownFetch<T>(fetcher));
      return bloc;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<DropdownBloc<BrandModel>>(
          create: (_) => createDropdownBloc(
            () => DropdownRemoteDataSource(dio: sl<Dio>()).fetchBrands(),
          ),
        ),
        BlocProvider<DropdownBloc<CategoryModel>>(
          create: (_) => createDropdownBloc(
            () => DropdownRemoteDataSource(dio: sl<Dio>()).fetchCategories(),
          ),
        ),
        BlocProvider<DropdownBloc<AvailabilityModel>>(
          create: (_) => createDropdownBloc(
            () => DropdownRemoteDataSource(dio: sl<Dio>()).fetchAvailability(),
          ),
        ),
        BlocProvider<DropdownBloc<Map<String, dynamic>>>(
          create: (_) => createDropdownBloc(
            () async {
              // await Future.delayed(const Duration(seconds: 1)); // simulate API
              return [
                {'id': 1, 'label': 'Same Day'},
                {'id': 2, 'label': 'Next Day'},
                {'id': 3, 'label': '2-3 Days'},
                {'id': 4, 'label': '3-5 Days'},
                {'id': 5, 'label': '1 Week'},
                {'id': 6, 'label': '2 Weeks'},
                {'id': 7, 'label': '1 Month'},
              ];
            },
          ),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
