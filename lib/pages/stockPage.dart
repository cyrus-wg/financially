import 'package:auto_route/auto_route.dart';
import 'package:financially/components/priceTrendChart.dart';
import 'package:financially/components/stockHeader.dart';
import 'package:financially/components/stockNews.dart';
import 'package:financially/utils/marked.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  final String ticker;
  StockPage({super.key, @PathParam('ticker') required this.ticker});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late bool mark;

  Future togglemark() async {
    await switchMarked(widget.ticker, mark);
    setState(() {
      mark = mark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: marked(widget.ticker),
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
                  StockNews(ticker: widget.ticker),
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
