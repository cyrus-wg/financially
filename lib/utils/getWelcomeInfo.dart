import 'dart:typed_data';

import 'package:financially/utils/getImg.dart';
import 'package:financially/utils/watchlist.dart';

Future<Map<String, dynamic>> getWelcomeInfo(String ticker) async {
  final bool m = await getWatched(ticker);
  final Uint8List? i = await getImg(ticker);
  return {'marked': m, 'image': i};
}
