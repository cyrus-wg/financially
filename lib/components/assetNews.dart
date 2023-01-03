import 'package:auto_route/auto_route.dart';
import 'package:financially/components/loading.dart';
import 'package:financially/components/newsCard.dart';
import 'package:financially/router/router.gr.dart';
import 'package:financially/utils/getNews.dart';
import 'package:flutter/material.dart';

class AssetNews extends StatefulWidget {
  late String ticker;
  late int num;
  AssetNews({super.key, required this.ticker, this.num = 5});

  @override
  State<AssetNews> createState() => _AssetNewsState();
}

class _AssetNewsState extends State<AssetNews> {
  late Future<List<dynamic>> _future;
  @override
  void initState() {
    _future = getNews(widget.ticker);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final news = snapshot.data;
          if (news!.isEmpty) {
            return Container();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'News',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.pinkAccent,
                  ),
                ),
                const SizedBox(height: 7),
                ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: List.generate(
                      widget.num, (index) => NewsCard(data: news[index])),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await context.router.push(NewsRoute(
                          news: {'ticker': widget.ticker, 'news': news}));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(250, 50),
                      backgroundColor: Colors.pink.shade500.withOpacity(0.9),
                    ),
                    child: const Text(
                      'View more news',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: Loading(),
              ),
            ),
          );
        }
      },
    );
  }
}
