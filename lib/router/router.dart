import 'package:financially/pages/authPage.dart';
import 'package:financially/pages/mainPage.dart';
import 'package:financially/pages/newsPage.dart';
import 'package:financially/pages/searchPage.dart';
import 'package:financially/pages/stockPage.dart';
import 'package:financially/pages/welcomePage.dart';

import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: MainPage, path: '/'),
    AutoRoute(page: AuthPage, path: '/auth'),
    AutoRoute(page: SearchPage, path: '/search'),
    AutoRoute(page: WelcomePage, path: '/welcome'),
    AutoRoute(page: StockPage, path: '/stock/:ticker'),
    AutoRoute(page: NewsPage, path: '/news/:ticker'),
  ],
)
class $AppRouter {}
