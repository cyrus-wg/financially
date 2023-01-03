import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:financially/pages/authPage.dart';
import 'package:financially/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uni_links/uni_links.dart';

bool _initialURILinkHandled = false;

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

// accept deep link financially://unilinks.com/asset/*
class _RootPageState extends State<RootPage> {
  final user = FirebaseAuth.instance.currentUser;
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;
  String ticker = '';
  final regex = RegExp(r'^/asset/\w+');

  StreamSubscription? _streamSubscription;

  Future<void> _initURIHandler() async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      Fluttertoast.showToast(
          msg: "Invoked _initURIHandler",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white);
      try {
        final initialURI = await getInitialUri();
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          if (!mounted) {
            return;
          }
          setState(() {
            _initialURI = initialURI;
          });
        } else {
          debugPrint("Null Initial URI received");
        }
      } on PlatformException {
        debugPrint("Failed to receive initial uri");
      } on FormatException catch (err) {
        if (!mounted) {
          return;
        }
        debugPrint('Malformed Initial URI received');
        setState(() => _err = err);
      }
    }
  }

  void _incomingLinkHandler() {
    if (!kIsWeb) {
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (!mounted) {
          return;
        }
        debugPrint('Received URI: $uri');
        setState(() {
          _currentURI = uri;
          _err = null;

          // WidgetsBinding.instance.addPersistentFrameCallback(
          //   (_) {
          //     context.router.pushNamed('/asset/AAPL');
          //   },
          // );
        });
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        debugPrint('Error occurred: $err');
        setState(() {
          _currentURI = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initURIHandler();
    _incomingLinkHandler();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool coolStart =
        _initialURI.toString() != 'null' && _currentURI.toString() == 'null';
    bool popup = _currentURI.toString() != 'null';
    if (coolStart) {
      final path = _initialURI?.path;
      if (path != null) {
        if (regex.hasMatch(path)) {
          ticker = path.substring(7);
        }
      }
    } else if (popup) {
      final path = _currentURI?.path;
      if (path != null) {
        if (regex.hasMatch(path)) {
          ticker = path.substring(7);
        }
      }
    }

    String t = ticker.toUpperCase();
    ticker = '';

    if (user == null) {
      return AuthPage();
    } else {
      if (t != '' && coolStart) {
        // context.router.pop();
        context.router.navigateNamed('/asset/$t');
      } else if (t != '' && popup) {
        context.router.pushNamed('/asset/$t');
      }
      return HomePage();
    }
  }
}
