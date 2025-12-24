import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homekru_owner/core/routes/app_routes.dart';

class AppNavigator {
  AppNavigator._();

  static GoRouter get _router => AppRoutes.router;

  static BuildContext? get _context => navigationKey.currentContext;

  static void go(String location, {Object? extra}) {
    _router.go(location, extra: extra);
  }

  static void push(String location, {Object? extra}) {
    _router.push(location, extra: extra);
  }

  static void pushReplacement(String location, {Object? extra}) {
    _router.pushReplacement(location, extra: extra);
  }

  static void pop<T extends Object?>([T? result]) {
    if (_context != null && _router.canPop()) {
      _router.pop(result);
    } else {
      _router.routerDelegate.navigatorKey.currentState?.maybePop(result);
    }
  }

  static void goNamed(
    String name, {
    Map<String, String> pathParams = const {},
    Object? extra,
  }) {
    _router.goNamed(name, pathParameters: pathParams, extra: extra);
  }

  static void replaceNamed(
    String name, {
    Map<String, String> pathParams = const {},
    Object? extra,
  }) {
    _router.replaceNamed(name, pathParameters: pathParams, extra: extra);
  }

  static void pushNamed(
    String name, {
    Map<String, String> pathParams = const {},
    Object? extra,
  }) {
    _router.pushNamed(name, pathParameters: pathParams, extra: extra);
  }

  static String currentLocation() =>
      _router.routerDelegate.currentConfiguration.uri.toString();

  static bool canPop() => _router.canPop();
}
