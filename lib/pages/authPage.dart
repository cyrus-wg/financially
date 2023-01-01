import 'package:auto_route/auto_route.dart';
import 'package:financially/components/auth.dart';
import 'package:financially/router/router.gr.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  String currentPage;
  AuthPage({super.key, this.currentPage = 'signin'});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu_rounded),
            tooltip: 'Menu',
          );
        }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_rounded),
            tooltip: 'Notifications',
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).padding.top + kToolbarHeight)) *
                    .30,
                color: Colors.pink,
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).padding.top + kToolbarHeight)) *
                    .70,
                color: Colors.white,
              ),
            ],
          ),
          ListView(
            children: [
              Auth(option: widget.currentPage),
            ],
          ),
        ],
      ),
      drawer: Drawer(
          width: 270,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 140,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                  ),
                  child: Center(
                    child: Text(
                      'Financially!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Center(
                    child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 25,
                  ),
                )),
                onTap: () {
                  setState(() {
                    widget.currentPage = 'signup';
                  });
                  context.router.popUntil((_) => false);
                  context.router.push(AuthRoute(currentPage: 'signup'));
                },
              ),
              const Divider(),
              ListTile(
                title: const Center(
                    child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 25,
                  ),
                )),
                onTap: () {
                  setState(() {
                    widget.currentPage = 'signin';
                  });
                  context.router.popUntil((_) => false);
                  context.router.push(AuthRoute(currentPage: 'signin'));
                },
              ),
              const Divider(),
            ],
          )),
    );
  }
}
