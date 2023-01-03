import 'package:financially/components/newsCard.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  final Map<String, dynamic> news;
  const NewsPage({super.key, required this.news});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.news['ticker']}\'s News')),
      body: Container(
        color: Colors.pink.shade100,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.news['news']!.length,
              cacheExtent: 3000,
              itemBuilder: (context, index) =>
                  NewsCard(data: widget.news['news'][index]),
            ),
          ],
        ),
      ),
    );
  }
}
