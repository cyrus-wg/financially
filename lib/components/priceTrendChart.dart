import 'package:financially/components/loading.dart';
import 'package:financially/utils/getPriceTrend.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceTrendChart extends StatefulWidget {
  final String ticker;
  int duration;
  PriceTrendChart({super.key, required this.ticker, this.duration = 1});

  @override
  State<PriceTrendChart> createState() => _PriceTrendChartState();
}

class _PriceTrendChartState extends State<PriceTrendChart> {
  @override
  Widget build(BuildContext context) {
    late List<double> priceList;
    return FutureBuilder(
        future: getPriceTrend(widget.ticker, widget.duration),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data![0] == -1) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.width * 0.5,
                child: const Center(
                  child: Text(
                    'Stock not found',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else if (data[0] == -2) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: MediaQuery.of(context).size.width * 0.5,
                child: const Center(
                  child: Text(
                    'Error, please try again later',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            } else {
              priceList = snapshot.data!;
              final List<FlSpot> trends =
                  List.generate(priceList.length, (index) {
                return FlSpot(index.toDouble(), priceList[index]);
              });

              return Column(
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
                              backgroundColor: widget.duration == 1
                                  ? null
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.duration = 1;
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
                              backgroundColor: widget.duration == 30
                                  ? null
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.duration = 30;
                              });
                            },
                            child: const Text('30D'),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.duration == 90
                                  ? null
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.duration = 90;
                              });
                            },
                            child: const Text('3M'),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.duration == 180
                                  ? null
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.duration = 180;
                              });
                            },
                            child: const Text('6M'),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.duration == 360
                                  ? null
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.duration = 360;
                              });
                            },
                            child: const Text('1Y'),
                          ),
                        ),
                        Card(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.duration == 0
                                  ? null
                                  : Colors.transparent,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.duration = 0;
                              });
                            },
                            child: const Text('All'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(
                            border: const Border(
                              bottom: BorderSide(),
                              left: BorderSide(),
                            ),
                          ),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            // leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: FlGridData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: trends,
                              isCurved: false,
                              dotData: FlDotData(
                                show: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: const Loading(),
                ),
              ),
            );
          }
        });
  }
}
