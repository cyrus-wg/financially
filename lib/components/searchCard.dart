import 'package:financially/utils/marked.dart';
import 'package:flutter/material.dart';

// TODO: direct to specific stock page

class SearchCard extends StatefulWidget {
  final bool pressable;
  final String name;
  final String ticker;
  late bool marked;
  SearchCard(
      {super.key,
      required this.name,
      required this.ticker,
      this.pressable = true});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  Future togglemark() async {
    if (!widget.marked) {
      await mark(widget.ticker);
    } else {
      await unmark(widget.ticker);
    }
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
            onTap: () {
              if (widget.pressable) {
                print('pressable');
              }
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
