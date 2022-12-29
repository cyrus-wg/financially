import 'package:financially/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'router/router.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // print(user);
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      routerDelegate: _appRouter.delegate(initialRoutes: [
        if (user == null) AuthRoute(),
        if (user != null) MainRoute(),
      ]),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
