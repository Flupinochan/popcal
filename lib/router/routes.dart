import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:popcal/features/home/presentation/screens/home_screen.dart';
import 'package:popcal/features/month_end/presentation/screens/month_end_screen.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/presentation/screens/rotation_screen.dart';
import 'package:popcal/shared/screens/custom_error_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<CalendarRoute>(path: '/calendar/:id')
class CalendarRoute extends GoRouteData with _$CalendarRoute {
  const CalendarRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final rotationId = RotationId(id);
    return CalendarScreen(rotationId: rotationId);
  }
}

@TypedGoRoute<ErrorRoute>(path: '/error')
class ErrorRoute extends GoRouteData with _$ErrorRoute {
  const ErrorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CustomErrorScreen();
  }
}

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => HomeScreen();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<MonthEndRoute>(path: '/month-end')
class MonthEndRoute extends GoRouteData with _$MonthEndRoute {
  const MonthEndRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MonthEndScreen();
  }
}

@TypedGoRoute<RotationCreateRoute>(path: '/rotation')
class RotationCreateRoute extends GoRouteData with _$RotationCreateRoute {
  const RotationCreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RotationScreen();
  }
}

@TypedGoRoute<RotationUpdateRoute>(path: '/rotation/:id')
class RotationUpdateRoute extends GoRouteData with _$RotationUpdateRoute {
  const RotationUpdateRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final rotationId = RotationId(id);
    return RotationScreen(rotationId: rotationId);
  }
}
