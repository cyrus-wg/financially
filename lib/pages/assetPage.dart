import 'package:auto_route/auto_route.dart';
import 'package:financially/components/assetNews.dart';
import 'package:financially/components/priceTrendChart.dart';
import 'package:financially/components/stockHeader.dart';
import 'package:financially/utils/watchlist.dart';
import 'package:flutter/material.dart';

class AssetPage extends StatefulWidget {
  final String ticker;
  const AssetPage({super.key, @PathParam('ticker') required this.ticker});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  late bool mark;

  Future togglemark() async {
    await switchWatched(widget.ticker);
    setState(() {
      mark = mark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWatched(widget.ticker),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          mark = snapshot.data!;
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
                  onPressed: () async {},
                ),
              ],
            ),
            body: Container(
              color: Colors.pink.shade100,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                cacheExtent: 1500,
                children: [
                  StockHeader(ticker: widget.ticker),
                  PriceTrendChart(ticker: widget.ticker),
                  AssetNews(ticker: widget.ticker),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
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
