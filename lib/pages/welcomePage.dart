import 'package:auto_route/auto_route.dart';
import 'package:financially/components/showSnackBar.dart';
import 'package:financially/components/welcomeCard.dart';
import 'package:financially/utils/getAllImgName.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late List<String> tickers;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: false,
        elevation: 0,
        title: const Text(
          'Welcome!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            icon: const Icon(
              Icons.close_rounded,
            ),
            tooltip: 'close',
            onPressed: () {
              context.router.replaceNamed('/');
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context)
                  .showSnackBar(showSnackBar('Welcome to Financially!'));
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: getAllImgName(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              tickers = snapshot.data!;
              return Container(
                decoration: BoxDecoration(color: Colors.pink.shade100),
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Container(
                      height: 135,
                      padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                      decoration: const BoxDecoration(color: Colors.pink),
                      child: Column(
                        children: [
                          Text(
                            'Choose your interests to follow and trade on your terms.',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: (() async {
                              await context.router.pushNamed('/search');
                              setState(() {});
                            }),
                            child: TextField(
                              enabled: false,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  size: 30,
                                ),
                                hintText: 'Search',
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      cacheExtent: 1500,
                      children: List.generate(
                        tickers.length,
                        (index) => Center(
                          child: Container(
                              height: MediaQuery.of(context).size.width * 0.5,
                              width: MediaQuery.of(context).size.width * 0.4,
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: welcomeCard(ticker: tickers[index]))),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          context.router.replaceNamed('/');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(showSnackBar('Welcome to Financially!'));
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.pink.withOpacity(0.9),
        ),
        child: const Text(
          'G O',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
