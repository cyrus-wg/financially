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
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../pages/assetPage.dart' as _i7;
import '../pages/authPage.dart' as _i2;
import '../pages/homePage.dart' as _i3;
import '../pages/hotStocksPage.dart' as _i6;
import '../pages/newsPage.dart' as _i8;
import '../pages/rootPage.dart' as _i1;
import '../pages/searchPage.dart' as _i5;
import '../pages/welcomePage.dart' as _i4;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    RootRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.RootPage(),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.AuthPage(
          key: args.key,
          currentPage: args.currentPage,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.WelcomePage(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.SearchPage(),
      );
    },
    HotStocksRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HotStocksPage(),
      );
    },
    AssetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssetRouteArgs>(
          orElse: () => AssetRouteArgs(ticker: pathParams.getString('ticker')));
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.AssetPage(
          key: args.key,
          ticker: args.ticker,
        ),
      );
    },
    NewsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<NewsRouteArgs>(
          orElse: () => NewsRouteArgs(ticker: pathParams.getString('ticker')));
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.NewsPage(
          key: args.key,
          ticker: args.ticker,
        ),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          RootRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          AuthRoute.name,
          path: '/auth',
        ),
        _i9.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i9.RouteConfig(
          WelcomeRoute.name,
          path: '/welcome',
        ),
        _i9.RouteConfig(
          SearchRoute.name,
          path: '/search',
        ),
        _i9.RouteConfig(
          HotStocksRoute.name,
          path: '/hotstocks',
        ),
        _i9.RouteConfig(
          AssetRoute.name,
          path: '/asset/:ticker',
        ),
        _i9.RouteConfig(
          NewsRoute.name,
          path: '/news/:ticker',
        ),
      ];
}

/// generated route for
/// [_i1.RootPage]
class RootRoute extends _i9.PageRouteInfo<void> {
  const RootRoute()
      : super(
          RootRoute.name,
          path: '/',
        );

  static const String name = 'RootRoute';
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i9.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i10.Key? key,
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

  final _i10.Key? key;

  final String currentPage;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, currentPage: $currentPage}';
  }
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.WelcomePage]
class WelcomeRoute extends _i9.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i5.SearchPage]
class SearchRoute extends _i9.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i6.HotStocksPage]
class HotStocksRoute extends _i9.PageRouteInfo<void> {
  const HotStocksRoute()
      : super(
          HotStocksRoute.name,
          path: '/hotstocks',
        );

  static const String name = 'HotStocksRoute';
}

/// generated route for
/// [_i7.AssetPage]
class AssetRoute extends _i9.PageRouteInfo<AssetRouteArgs> {
  AssetRoute({
    _i10.Key? key,
    required String ticker,
  }) : super(
          AssetRoute.name,
          path: '/asset/:ticker',
          args: AssetRouteArgs(
            key: key,
            ticker: ticker,
          ),
          rawPathParams: {'ticker': ticker},
        );

  static const String name = 'AssetRoute';
}

class AssetRouteArgs {
  const AssetRouteArgs({
    this.key,
    required this.ticker,
  });

  final _i10.Key? key;

  final String ticker;

  @override
  String toString() {
    return 'AssetRouteArgs{key: $key, ticker: $ticker}';
  }
}

/// generated route for
/// [_i8.NewsPage]
class NewsRoute extends _i9.PageRouteInfo<NewsRouteArgs> {
  NewsRoute({
    _i10.Key? key,
    required String ticker,
  }) : super(
          NewsRoute.name,
          path: '/news/:ticker',
          args: NewsRouteArgs(
            key: key,
            ticker: ticker,
          ),
          rawPathParams: {'ticker': ticker},
        );

  static const String name = 'NewsRoute';
}

class NewsRouteArgs {
  const NewsRouteArgs({
    this.key,
    required this.ticker,
  });

  final _i10.Key? key;

  final String ticker;

  @override
  String toString() {
    return 'NewsRouteArgs{key: $key, ticker: $ticker}';
  }
}
