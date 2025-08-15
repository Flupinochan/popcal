// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $calendarRoute,
  $deadlineRoute,
  $errorRoute,
  $homeRoute,
  $loginRoute,
  $rotationCreateRoute,
  $rotationUpdateRoute,
];

RouteBase get $calendarRoute => GoRouteData.$route(
  path: '/calendar/:id',

  factory: _$CalendarRoute._fromState,
);

mixin _$CalendarRoute on GoRouteData {
  static CalendarRoute _fromState(GoRouterState state) =>
      CalendarRoute(id: state.pathParameters['id']!);

  CalendarRoute get _self => this as CalendarRoute;

  @override
  String get location =>
      GoRouteData.$location('/calendar/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $deadlineRoute =>
    GoRouteData.$route(path: '/deadline', factory: _$DeadlineRoute._fromState);

mixin _$DeadlineRoute on GoRouteData {
  static DeadlineRoute _fromState(GoRouterState state) => const DeadlineRoute();

  @override
  String get location => GoRouteData.$location('/deadline');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $errorRoute =>
    GoRouteData.$route(path: '/error', factory: _$ErrorRoute._fromState);

mixin _$ErrorRoute on GoRouteData {
  static ErrorRoute _fromState(GoRouterState state) => const ErrorRoute();

  @override
  String get location => GoRouteData.$location('/error');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute =>
    GoRouteData.$route(path: '/', factory: _$HomeRoute._fromState);

mixin _$HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: _$LoginRoute._fromState);

mixin _$LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rotationCreateRoute => GoRouteData.$route(
  path: '/rotation',

  factory: _$RotationCreateRoute._fromState,
);

mixin _$RotationCreateRoute on GoRouteData {
  static RotationCreateRoute _fromState(GoRouterState state) =>
      const RotationCreateRoute();

  @override
  String get location => GoRouteData.$location('/rotation');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rotationUpdateRoute => GoRouteData.$route(
  path: '/rotation/:id',

  factory: _$RotationUpdateRoute._fromState,
);

mixin _$RotationUpdateRoute on GoRouteData {
  static RotationUpdateRoute _fromState(GoRouterState state) =>
      RotationUpdateRoute(id: state.pathParameters['id']!);

  RotationUpdateRoute get _self => this as RotationUpdateRoute;

  @override
  String get location =>
      GoRouteData.$location('/rotation/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
