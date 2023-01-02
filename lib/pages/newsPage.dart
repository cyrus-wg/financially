import 'package:auto_route/auto_route.dart';
import 'package:financially/components/loading.dart';
import 'package:financially/components/newsCard.dart';
import 'package:financially/utils/getNews.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  final String ticker;
  const NewsPage({super.key, @PathParam('ticker') required this.ticker});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
          return Scaffold(
            appBar: AppBar(title: Text('${widget.ticker}\'s News')),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: ListView.builder(
                itemCount: news!.length,
                cacheExtent: 3000,
                itemBuilder: (context, index) => NewsCard(data: news[index]),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: Text('${widget.ticker}\'s News')),
            body: const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Loading(),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
