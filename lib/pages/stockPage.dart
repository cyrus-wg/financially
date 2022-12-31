import 'package:auto_route/auto_route.dart';
import 'package:financially/components/priceTrendChart.dart';
import 'package:financially/router/router.gr.dart';
import 'package:financially/utils/getStockInfo.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  final String ticker;
  StockPage({super.key, @PathParam('ticker') required this.ticker});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  int duration = 1;
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
                  Container(
                    height: 70,
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  duration == 1 ? null : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                duration = 1;
                              });
                            },
                            child: const Text(
                              '1D',
                            ),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  duration == 30 ? null : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                duration = 30;
                              });
                            },
                            child: const Text('30D'),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  duration == 90 ? null : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                duration = 90;
                              });
                            },
                            child: const Text('3M'),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  duration == 180 ? null : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                duration = 180;
                              });
                            },
                            child: const Text('6M'),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  duration == 360 ? null : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                duration = 360;
                              });
                            },
                            child: const Text('1Y'),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  duration == 0 ? null : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                duration = 0;
                              });
                            },
                            child: const Text('All'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PriceTrendChart(ticker: widget.ticker, duration: duration),
                ],
              ),
            ),
          );
        });
  }
}
