import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:financially/utils/getHotCard.dart';
import 'package:flutter/material.dart';

class HotStockCard extends StatefulWidget {
  final String ticker;
  const HotStockCard({super.key, required this.ticker});

  @override
  State<HotStockCard> createState() => _HotStockCardState();
}

class _HotStockCardState extends State<HotStockCard> {
  late Uint8List image;
  late String price;
  late String pert;
  late String value;
  late Future<Map<String, dynamic>> _future;

  @override
  void initState() {
    _future = getHotCard(widget.ticker);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            image = data!['image'];
            price = double.parse(data['price']).toStringAsFixed(2);
            pert = double.parse(data['percent_change']).toStringAsFixed(2);
            value = double.parse(data['change']).toStringAsFixed(2);
            price = price[0] != '-' ? '+$price' : price;
            pert = pert[0] != '-' ? '+$pert%' : '$pert%';
            value = value[0] != '-' ? '+$value' : value;

            return InkWell(
              onTap: () {
                context.router.pushNamed('/stock/${widget.ticker}');
              },
              child: Container(
                height: MediaQuery.of(context).size.width * 0.55,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.2,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Image.memory(image),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.ticker,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: pert[0] == '+'
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                            ),
                            child: Text(
                              pert,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: pert[0] == '+'
                                    ? Colors.green.shade600
                                    : Colors.red.shade600,
                              ),
                            ),
                          ),
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.width * 0.55,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.55,
                width: MediaQuery.of(context).size.width * 0.45,
                child: const CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
