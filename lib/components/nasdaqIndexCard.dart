import 'package:financially/utils/getLatestPriceInfo.dart';
import 'package:flutter/material.dart';

class NasdaqIndexCard extends StatefulWidget {
  const NasdaqIndexCard({super.key});

  @override
  State<NasdaqIndexCard> createState() => _NasdaqIndexCardState();
}

class _NasdaqIndexCardState extends State<NasdaqIndexCard> {
  late String price;
  late String pert;
  late String value;
  late Future<Map<String, dynamic>> _future;
  @override
  void initState() {
    _future = getLatestPriceInfo('IXIC');
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.35,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: value[0] == '+'
                      ? Colors.green.withOpacity(0.9)
                      : value[0] == '-'
                          ? Colors.red.withOpacity(0.9)
                          : Colors.grey.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'NASDAQ',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pert,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              value,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
