import 'package:equatable/equatable.dart';

/// States
abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded({
    required this.totalUsers,
    required this.activeUsers,
    required this.revenue,
  });
  final int totalUsers;
  final int activeUsers;
  final double revenue;

  @override
  List<Object?> get props => [totalUsers, activeUsers, revenue];
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
