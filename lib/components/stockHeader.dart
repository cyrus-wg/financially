import 'package:financially/components/loading.dart';
import 'package:financially/utils/getLatestPriceInfo.dart';
import 'package:flutter/material.dart';

class StockHeader extends StatefulWidget {
  final String ticker;
  const StockHeader({super.key, required this.ticker});

  @override
  State<StockHeader> createState() => _StockHeaderState();
}

class _StockHeaderState extends State<StockHeader> {
  late Future<Map<String, dynamic>> _future;
  late String price;
  late String pert;
  late String value;
  @override
  void initState() {
    _future = getLatestPriceInfo(widget.ticker);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
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
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
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
                  const SizedBox(width: 10),
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
            );
          } else {
            return const SizedBox(
              height: 150,
              child: Center(
                child: Loading(),
              ),
            );
          }
        });
  }
}
