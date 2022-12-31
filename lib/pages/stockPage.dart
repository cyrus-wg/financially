import 'package:auto_route/auto_route.dart';
import 'package:financially/components/priceTrendChart.dart';
import 'package:financially/utils/getStockInfo.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  final String ticker;
  StockPage({super.key, @PathParam('ticker') required this.ticker});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late Future<Map<String, dynamic>> _future;

  @override
  void initState() {
    _future = getStockInfo(widget.ticker);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.ticker),
            ),
            body: Container(
              color: Colors.pink.shade100,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView(
                children: [
                  PriceTrendChart(ticker: widget.ticker),
                ],
              ),
            ),
          );
        });
  }
}
