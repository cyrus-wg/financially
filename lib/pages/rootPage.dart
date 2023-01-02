import 'package:financially/pages/authPage.dart';
import 'package:financially/pages/homePage.dart';
import 'package:financially/pages/welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return HomePage();
    // if (user == null) {
    //   return AuthPage();
    // } else {
    //   return HomePage();
    // }
  }
}
