import 'dart:math';

import 'package:auto_route/auto_route.dart';
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

  late Future<List<String>> _future;

  @override
  void initState() {
    _future = getAllImgName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            imgList = snapshot.data!;
            resetSelectedImg();
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Hot Stocks',
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              await context.router.pushNamed('/hotstocks');
                              setState(() {});
                            },
                            child: const Text(
                              'View More',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: HotStockCard(ticker: selectedImg[index]),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
