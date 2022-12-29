import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  final String ticker;
  const StockPage({super.key, @PathParam('ticker') required this.ticker});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(widget.ticker),
      ),
    );
  }
}
