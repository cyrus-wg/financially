import 'package:auto_route/auto_route.dart';
import 'package:financially/components/loading.dart';
import 'package:financially/utils/getPriceHistory.dart';
import 'package:flutter/material.dart';

class HistoricalDataPage extends StatefulWidget {
  final String ticker;
  const HistoricalDataPage(
      {super.key, @PathParam('ticker') required this.ticker});

  @override
  State<HistoricalDataPage> createState() => _HistoricalDataPageState();
}

class _HistoricalDataPageState extends State<HistoricalDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.ticker}\'s Historical Data'),
      ),
      body: FutureBuilder(
        future: getPricesHistory(widget.ticker),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final prices = snapshot.data;

            return Container(
              color: Colors.pink.shade100,
              child: ListView.builder(
                itemCount: prices!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              prices[index]['date'],
                              style: const TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'open: ${prices[index]['open']}',
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'close: ${prices[index]['close']}',
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'low ${prices[index]['low']}',
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'high ${prices[index]['high']}',
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container(
              color: Colors.pink.shade100,
              child: const Center(
                child: Loading(),
              ),
            );
          }
        },
      ),
    );
  }
}
