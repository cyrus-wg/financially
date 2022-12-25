import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:financially/firebase_options.dart';
import 'package:financially/pages/authPage.dart';
import 'package:financially/pages/mainPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: root(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class root extends StatelessWidget {
  const root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              FirebaseAuth.instance.signOut();
              final user = FirebaseAuth.instance.currentUser;
              // print(user);
              if (user == null) {
                return AuthPage();
              } else {
                return MainPage();
              }
            default:
              return const Center(child: Text('Loading'));
          }
        },
      ),
    );
  }
}
