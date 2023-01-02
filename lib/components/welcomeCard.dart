import 'dart:typed_data';

import 'package:financially/utils/getWelcomeInfo.dart';
import 'package:financially/utils/watchlist.dart';
import 'package:flutter/material.dart';

class welcomeCard extends StatefulWidget {
  final String ticker;
  welcomeCard({super.key, required this.ticker});

  @override
  State<welcomeCard> createState() => _welcomeCardState();
}

class _welcomeCardState extends State<welcomeCard> {
  late Uint8List image;
  late bool marked;
  Future togglemark() async {
    await switchWatched(widget.ticker);
    setState(() {
      marked = !marked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getWelcomeInfo(widget.ticker),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> d = snapshot.data!;
            marked = d['marked'];
            image = d['image'];
            return Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Image.memory(image),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.ticker,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () async {
                      await togglemark();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          marked ? Colors.pink.shade100 : Colors.pinkAccent,
                      minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.25,
                          MediaQuery.of(context).size.width * 0.1),
                    ),
                    child: Text(
                      marked ? 'Followed' : 'Follow',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: marked ? Colors.blueGrey : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: const CircularProgressIndicator(),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
