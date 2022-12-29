import 'package:auto_route/auto_route.dart';
import 'package:financially/utils/marked.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  final String name;
  final String ticker;
  late bool marked;
  SearchCard({super.key, required this.name, required this.ticker});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  Future togglemark() async {
    await switchMarked(widget.ticker, widget.marked);
    setState(() {
      widget.marked = !widget.marked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: marked(widget.ticker),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            widget.marked = snapshot.data!;
            return _card();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _card() => Card(
        child: Ink(
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.white38,
          ),
          child: InkWell(
            splashColor: Colors.pinkAccent,
            onTap: () async {
              context.router.pushNamed('/stock/${widget.ticker}');
              setState(() {});
            },
            child: Center(
              child: ListTile(
                title: Text(
                  widget.ticker,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.name,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  iconSize: 40,
                  color: widget.marked == true ? Colors.pink : null,
                  icon: const Icon(
                    Icons.star_rate_rounded,
                  ),
                  onPressed: () async {
                    await togglemark();
                  },
                ),
              ),
            ),
          ),
        ),
      );
}
