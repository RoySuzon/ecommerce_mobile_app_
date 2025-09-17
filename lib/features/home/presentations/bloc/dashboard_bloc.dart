import 'package:ecommerce_app/features/home/presentations/bloc/dashboard_event.dart';
import 'package:ecommerce_app/features/home/presentations/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardLoading()) {
    on<LoadDashboard>((event, emit) async {
      try {
        await Future.delayed(const Duration(seconds: 1)); // simulate API call
        emit(
          const DashboardLoaded(
            totalUsers: 1200,
            activeUsers: 856,
            revenue: 25480.75,
          ),
        );
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
  }
}
