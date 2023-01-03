import 'package:auto_route/auto_route.dart';
import 'package:financially/components/loading.dart';
import 'package:financially/utils/getLatestPriceInfo.dart';
import 'package:financially/utils/watchlist.dart';
import 'package:flutter/material.dart';

class PortfolioCard extends StatefulWidget {
  final String ticker;
  const PortfolioCard({super.key, required this.ticker});

  @override
  State<PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
  late String price;
  late String pert;
  late String value;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLatestPriceInfo(widget.ticker),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          price = double.parse(data!['price']).toStringAsFixed(3);
          double pertd = double.parse(
              double.parse(data['percent_change']).toStringAsFixed(2));
          double valued =
              double.parse(double.parse(data['change']).toStringAsFixed(2));
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

          return InkWell(
            onTap: () async {
              await context.router.pushNamed('/asset/${widget.ticker}');
              setState(() {});
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.pinkAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 40,
                    color: Colors.pink,
                    icon: const Icon(
                      Icons.star_rate_rounded,
                    ),
                    onPressed: () async {
                      await switchWatched(widget.ticker);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.pinkAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Loading(),
            ),
          );
        }
      },
    );
  }
}
