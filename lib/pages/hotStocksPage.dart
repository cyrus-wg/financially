import 'package:financially/components/hotStockCard.dart';
import 'package:financially/components/loading.dart';
import 'package:financially/utils/getAllImgName.dart';
import 'package:flutter/material.dart';

class HotStocksPage extends StatefulWidget {
  const HotStocksPage({super.key});

  @override
  State<HotStocksPage> createState() => _HotStocksPageState();
}

class _HotStocksPageState extends State<HotStocksPage> {
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
          final names = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Hot Stocks'),
            ),
            body: Container(
              color: Colors.pink.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  GridView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    children: List.generate(
                        names!.length,
                        (index) => Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.width * 0.5,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: HotStockCard(
                                    ticker: names[index],
                                  ),
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Loading());
        }
      },
    );
  }
}
