import 'package:auto_route/auto_route.dart';
import 'package:financially/components/loading.dart';
import 'package:financially/components/showSnackBar.dart';
import 'package:financially/models/AssetInfo.dart';
import 'package:financially/utils/watchlist.dart';

import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  final AssetInfo cardinfo;
  const SearchCard({super.key, required this.cardinfo});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  late bool watched;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getWatched(widget.cardinfo.ticker),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            watched = snapshot.data!;
            return _card();
          } else {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 130,
                child: const Loading(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _card() => Container(
        decoration: BoxDecoration(color: Colors.pink.shade100),
        child: Card(
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white38,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              splashColor: Colors.pinkAccent,
              onTap: () async {
                await context.router
                    .pushNamed('/asset/${widget.cardinfo.ticker}');
                setState(() {});
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.cardinfo.ticker,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.cardinfo.exchange}  ${widget.cardinfo.type}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              widget.cardinfo.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        iconSize: 40,
                        color: watched == true ? Colors.pink : Colors.grey,
                        icon: const Icon(
                          Icons.star_rate_rounded,
                        ),
                        onPressed: () async {
                          await switchWatched(widget.cardinfo.ticker);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          if (!watched) {
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
                                'Added ${widget.cardinfo.ticker} to watchlist'));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar(
                                'Removed ${widget.cardinfo.ticker} from watchlist'));
                          }
                          setState(
                            () {
                              watched = !watched;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
