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
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../pages/assetPage.dart' as _i7;
import '../pages/authPage.dart' as _i2;
import '../pages/historicalDataPage.dart' as _i9;
import '../pages/homePage.dart' as _i3;
import '../pages/hotStocksPage.dart' as _i6;
import '../pages/newsPage.dart' as _i8;
import '../pages/rootPage.dart' as _i1;
import '../pages/searchPage.dart' as _i5;
import '../pages/welcomePage.dart' as _i4;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    RootRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.RootPage(),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.AuthPage(
          key: args.key,
          currentPage: args.currentPage,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.WelcomePage(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.SearchPage(),
      );
    },
    HotStocksRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HotStocksPage(),
      );
    },
    AssetRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssetRouteArgs>(
          orElse: () => AssetRouteArgs(ticker: pathParams.getString('ticker')));
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.AssetPage(
          key: args.key,
          ticker: args.ticker,
        ),
      );
    },
    NewsRoute.name: (routeData) {
      final args = routeData.argsAs<NewsRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.NewsPage(
          key: args.key,
          news: args.news,
        ),
      );
    },
    HistoricalDataRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HistoricalDataRouteArgs>(
          orElse: () =>
              HistoricalDataRouteArgs(ticker: pathParams.getString('ticker')));
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.HistoricalDataPage(
          key: args.key,
          ticker: args.ticker,
        ),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          RootRoute.name,
          path: '/',
        ),
        _i10.RouteConfig(
          AuthRoute.name,
          path: '/auth',
        ),
        _i10.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i10.RouteConfig(
          WelcomeRoute.name,
          path: '/welcome',
        ),
        _i10.RouteConfig(
          SearchRoute.name,
          path: '/search',
        ),
        _i10.RouteConfig(
          HotStocksRoute.name,
          path: '/hotstocks',
        ),
        _i10.RouteConfig(
          AssetRoute.name,
          path: '/asset/:ticker',
        ),
        _i10.RouteConfig(
          NewsRoute.name,
          path: '/news',
        ),
        _i10.RouteConfig(
          HistoricalDataRoute.name,
          path: '/history/:ticker',
        ),
      ];
}

/// generated route for
/// [_i1.RootPage]
class RootRoute extends _i10.PageRouteInfo<void> {
  const RootRoute()
      : super(
          RootRoute.name,
          path: '/',
        );

  static const String name = 'RootRoute';
}

/// generated route for
/// [_i2.AuthPage]
class AuthRoute extends _i10.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i11.Key? key,
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

  final _i11.Key? key;

  final String currentPage;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, currentPage: $currentPage}';
  }
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.WelcomePage]
class WelcomeRoute extends _i10.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i5.SearchPage]
class SearchRoute extends _i10.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: '/search',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i6.HotStocksPage]
class HotStocksRoute extends _i10.PageRouteInfo<void> {
  const HotStocksRoute()
      : super(
          HotStocksRoute.name,
          path: '/hotstocks',
        );

  static const String name = 'HotStocksRoute';
}

/// generated route for
/// [_i7.AssetPage]
class AssetRoute extends _i10.PageRouteInfo<AssetRouteArgs> {
  AssetRoute({
    _i11.Key? key,
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

  final _i11.Key? key;

  final String ticker;

  @override
  String toString() {
    return 'AssetRouteArgs{key: $key, ticker: $ticker}';
  }
}

/// generated route for
/// [_i8.NewsPage]
class NewsRoute extends _i10.PageRouteInfo<NewsRouteArgs> {
  NewsRoute({
    _i11.Key? key,
    required Map<String, dynamic> news,
  }) : super(
          NewsRoute.name,
          path: '/news',
          args: NewsRouteArgs(
            key: key,
            news: news,
          ),
        );

  static const String name = 'NewsRoute';
}

class NewsRouteArgs {
  const NewsRouteArgs({
    this.key,
    required this.news,
  });

  final _i11.Key? key;

  final Map<String, dynamic> news;

  @override
  String toString() {
    return 'NewsRouteArgs{key: $key, news: $news}';
  }
}

/// generated route for
/// [_i9.HistoricalDataPage]
class HistoricalDataRoute extends _i10.PageRouteInfo<HistoricalDataRouteArgs> {
  HistoricalDataRoute({
    _i11.Key? key,
    required String ticker,
  }) : super(
          HistoricalDataRoute.name,
          path: '/history/:ticker',
          args: HistoricalDataRouteArgs(
            key: key,
            ticker: ticker,
          ),
          rawPathParams: {'ticker': ticker},
        );

  static const String name = 'HistoricalDataRoute';
}

class HistoricalDataRouteArgs {
  const HistoricalDataRouteArgs({
    this.key,
    required this.ticker,
  });

  final _i11.Key? key;

  final String ticker;

  @override
  String toString() {
    return 'HistoricalDataRouteArgs{key: $key, ticker: $ticker}';
  }
}
