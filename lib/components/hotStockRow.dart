import 'package:financially/components/hotStockCard.dart';
import 'package:flutter/material.dart';

class HotStockRow extends StatelessWidget {
  const HotStockRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Hot Stocks',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.55 + 25,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              children: [
                UnconstrainedBox(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: HotStockCard(ticker: 'AAPL'),
                  ),
                ),
                UnconstrainedBox(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: HotStockCard(ticker: 'GOOG'),
                  ),
                ),
                UnconstrainedBox(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: HotStockCard(ticker: 'INTC'),
                  ),
                ),
                UnconstrainedBox(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: HotStockCard(ticker: 'META'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
