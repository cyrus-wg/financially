// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../pages/authPage.dart' as _i2;
import '../pages/mainPage.dart' as _i1;
import '../pages/searchPage.dart' as _i3;
import '../pages/stockPage.dart' as _i5;
import '../pages/welcomePage.dart' as _i4;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.AuthPage(
          key: args.key,
          currentPage: args.currentPage,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SearchPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.WelcomePage(),
      );
    },
    StockRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<StockRouteArgs>(
          orElse: () => StockRouteArgs(ticker: pathParams.getString('ticker')));
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.StockPage(
          key: args.key,
          ticker: args.ticker,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          MainRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          AuthRoute.name,
          path: '/auth',
        ),
        _i6.RouteConfig(
          SearchRoute.name,
          path: '/search',
        ),
        _i6.RouteConfig(
          WelcomeRoute.name,
          path: '/welcome',
        ),
        _i6.RouteConfig(
          StockRoute.name,
          path: '/stock/:ticker',
        ),
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute()
      : super(
          MainRoute.name,
          path: '/',
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i6.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i7.Key? key,
    String currentPage = 'signin',
  }) : super(
          AuthRoute.name,
          path: '/auth',
          args: AuthRouteArgs(
            key: key,
            currentPage: currentPage,
          ),
        );

  static const String name = 'AuthRoute';
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.key,
    this.currentPage = 'signin',
  });

  final _i7.Key? key;

  final String currentPage;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, currentPage: $currentPage}';
  }
}

/// generated route for
/// [_i3.SearchPage]
class SearchRoute extends _i6.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i4.WelcomePage]
class WelcomeRoute extends _i6.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i5.StockPage]
class StockRoute extends _i6.PageRouteInfo<StockRouteArgs> {
  StockRoute({
    _i7.Key? key,
    required String ticker,
  }) : super(
          StockRoute.name,
          path: '/stock/:ticker',
          args: StockRouteArgs(
            key: key,
            ticker: ticker,
          ),
          rawPathParams: {'ticker': ticker},
        );

  static const String name = 'StockRoute';
}

class StockRouteArgs {
  const StockRouteArgs({
    this.key,
    required this.ticker,
  });

  final _i7.Key? key;

  final String ticker;

  @override
  String toString() {
    return 'StockRouteArgs{key: $key, ticker: $ticker}';
  }
}
