import 'dart:math';

import 'package:financially/components/hotStockCard.dart';
import 'package:financially/utils/getAllImgName.dart';
import 'package:flutter/material.dart';

class HotStockRow extends StatefulWidget {
  final int cardNum;
  const HotStockRow({super.key, this.cardNum = 3});

  @override
  State<HotStockRow> createState() => _HotStockRowState();
}

class _HotStockRowState extends State<HotStockRow> {
  late List<String> imgList;
  List<String> selectedImg = [];
  void resetSelectedImg() {
    selectedImg.clear();
    while (selectedImg.length < widget.cardNum) {
      int index = Random().nextInt(imgList.length);
      if (!selectedImg.contains(imgList[index])) {
        selectedImg.add(imgList[index]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllImgName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            imgList = snapshot.data!;
            resetSelectedImg();
            return Column(
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
                  child: ListView.builder(
                      itemCount: widget.cardNum,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return UnconstrainedBox(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: HotStockCard(ticker: selectedImg[index]),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
