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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getHotCard(widget.ticker),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            image = data!['image'];
            price = double.parse(data['price']).toStringAsFixed(3);
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
              onTap: () {
                context.router.pushNamed('/asset/${widget.ticker}');
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
                                  : pert[0] == '-'
                                      ? Colors.red.shade100
                                      : null,
                            ),
                            child: Text(
                              pert,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: pert[0] == '+'
                                    ? Colors.green.shade600
                                    : pert[0] == '-'
                                        ? Colors.red.shade600
                                        : Colors.grey.shade600,
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
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
