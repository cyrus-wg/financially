import 'package:auto_route/auto_route.dart';
import 'package:financially/pages/authPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('log out'),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          context.router.popUntil((_) => false);
          context.router.pushNamed('/auth');
        },
      ),
    );
  }
}
