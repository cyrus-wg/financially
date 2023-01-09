import 'package:auto_route/auto_route.dart';
import 'package:financially/components/headerCard.dart';
import 'package:financially/components/loading.dart';
import 'package:financially/components/showSnackBar.dart';
import 'package:financially/utils/getWatchedInfo.dart';
import 'package:financially/utils/watchlist.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List watchlist = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWatchedInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final list = snapshot.data!;
          if (list.isEmpty) {
            return ListView(
              children: [
                HeaderCard(),
                const Center(
                  child: Text(
                    'Start Exploring The Market',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
              ],
            );
          } else {
            for (var item in list) {
              late String price;
              late String pert;
              late String value;
              price = double.parse(item['price']).toStringAsFixed(3);
              double pertd = double.parse(
                  double.parse(item['percent_change']).toStringAsFixed(2));
              double valued =
                  double.parse(double.parse(item['change']).toStringAsFixed(2));
              price = '\$$price';
              if (pertd == 0) {
                pert = '0.00%';
              } else if (pertd > 0) {
                pert = '+$pertd%';
              } else {
                pert = '$pertd%';
              }
              if (valued == 0) {
                value = '\$0.00';
              } else if (valued > 0) {
                value = '+\$$valued';
              } else {
                value = '-\$${'$valued'.substring(1)}';
              }
              watchlist.add({
                'ticker': item['symbol'],
                'price': price,
                'value': value,
                'pert': pert
              });
            }
            return ListView(
              children: [
                HeaderCard(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: InkWell(
                            onTap: () async {
                              await context.router.pushNamed(
                                  '/asset/${watchlist[index]['ticker']}');
                              setState(() {});
                            },
                            child: Container(
                              height: 100,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: Colors.pinkAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    iconSize: 40,
                                    color: Colors.pink,
                                    icon: const Icon(
                                      Icons.star_rate_rounded,
                                    ),
                                    onPressed: () async {
                                      await switchWatched(
                                          watchlist[index]['ticker']);
                                      setState(() {
                                        watchlist.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(showSnackBar(
                                              'Removed ${watchlist[index]['ticker']} from watchlist'));
                                    },
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        watchlist[index]['ticker'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Container(
                                        width: 80,
                                        height: 35,
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: watchlist[index]['pert'][0] ==
                                                  '+'
                                              ? Colors.green.shade100
                                              : watchlist[index]['pert'][0] ==
                                                      '-'
                                                  ? Colors.red.shade100
                                                  : null,
                                        ),
                                        child: Center(
                                          child: Text(
                                            watchlist[index]['pert'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: watchlist[index]['pert']
                                                          [0] ==
                                                      '+'
                                                  ? Colors.green.shade600
                                                  : watchlist[index]['pert']
                                                              [0] ==
                                                          '-'
                                                      ? Colors.red.shade600
                                                      : Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    watchlist[index]['price'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        } else {
          return const Center(
            child: Loading(),
          );
        }
      },
    );
  }
}
