import 'package:auto_route/auto_route.dart';
import 'package:financially/components/assetNews.dart';
import 'package:financially/components/priceTrendChart.dart';
import 'package:financially/components/stockHeader.dart';
import 'package:financially/pages/searchPage.dart';
import 'package:financially/utils/getStockEntry.dart';
import 'package:financially/utils/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class AssetPage extends StatefulWidget {
  final String ticker;
  const AssetPage({super.key, @PathParam('ticker') required this.ticker});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  late bool mark;
  late String name;

  Future togglemark() async {
    await switchWatched(widget.ticker);
    setState(() {
      mark = mark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStocksEntry(widget.ticker),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          mark = data!['watched'];
          name = data['name'];
          if (name != '') {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.ticker),
                actions: [
                  IconButton(
                    iconSize: 35,
                    color: mark == true ? Colors.yellowAccent : null,
                    icon: const Icon(
                      Icons.star_rate_rounded,
                    ),
                    onPressed: () async {
                      await togglemark();
                    },
                  ),
                  IconButton(
                    iconSize: 35,
                    icon: const Icon(
                      Icons.share_rounded,
                    ),
                    onPressed: () async {
                      await Share.share(
                          'From Financially: \n$name \nfinancially://unilinks.com/asset/${widget.ticker}');
                    },
                  ),
                ],
              ),
              body: Container(
                color: Colors.pink.shade100,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView(
                  cacheExtent: 1500,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        name,
                        // textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    StockHeader(ticker: widget.ticker),
                    PriceTrendChart(ticker: widget.ticker),
                    AssetNews(ticker: widget.ticker),
                  ],
                ),
              ),
            );
          } else {
            context.router.replaceNamed('/search');
            return const SearchPage();
          }
        } else {
          return Container(
            color: Colors.pink.shade100,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
