import 'package:financially/pages/assetPage.dart';
import 'package:financially/pages/hotStocksPage.dart';
import 'package:financially/pages/newsPage.dart';
import 'package:financially/pages/searchPage.dart';
import 'package:financially/pages/welcomePage.dart';
import 'package:financially/pages/authPage.dart';
import 'package:financially/pages/homePage.dart';
import 'package:financially/pages/rootPage.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: RootPage, path: '/', initial: true),
    AutoRoute(page: AuthPage, path: '/auth'),
    AutoRoute(page: HomePage, path: '/home'),
    AutoRoute(page: WelcomePage, path: '/welcome'),
    AutoRoute(page: SearchPage, path: '/search'),
    AutoRoute(page: HotStocksPage, path: '/hotstocks'),
    AutoRoute(page: AssetPage, path: '/asset/:ticker'),
    AutoRoute(page: NewsPage, path: '/news')
  ],
)
class $AppRouter {}
