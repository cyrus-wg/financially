import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HotStockCard extends StatefulWidget {
  final String ticker;
  const HotStockCard({super.key, required this.ticker});

  @override
  State<HotStockCard> createState() => _HotStockCardState();
}

class _HotStockCardState extends State<HotStockCard> {
  late final Uint8List image;
  late final String price = '\$105.95';
  late final String pert = '-5.00%';
  late final String value = '+\$5.00';
  @override
  Widget build(BuildContext context) {
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
              child: Container(color: Colors.red),
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
              '$price',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: pert[0] == '+'
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                    ),
                    child: Text(
                      '$pert',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: pert[0] == '+'
                            ? Colors.green.shade600
                            : Colors.red.shade600,
                      ),
                    ),
                  ),
                  Text(
                    '$value',
                    style: TextStyle(
                      fontSize: 19,
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
  }
}
