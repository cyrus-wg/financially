import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            context.router.popUntil((_) => false);
            context.router.pushNamed('auth');
          },
          child: Text('logout')),
    );
  }
}
