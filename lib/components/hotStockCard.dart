import 'dart:typed_data';

import 'package:flutter/material.dart';

class HotStockCard extends StatefulWidget {
  final String ticker;
  late final Uint8List image;
  late final double price;
  HotStockCard({super.key, required this.ticker});

  @override
  State<HotStockCard> createState() => _HotStockCardState();
}

class _HotStockCardState extends State<HotStockCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
