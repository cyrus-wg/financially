import 'package:financially/components/hotStockRow.dart';
import 'package:financially/components/indexCard.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: const [
        IndexCard(name: 'NASDAQ', ticker: 'ixic'),
        IndexCard(name: 'DJIA', ticker: 'dji'),
        IndexCard(name: 'S&P 500', ticker: 'gspc'),
        HotStockRow(cardNum: 5),
      ],
    );
  }
}
