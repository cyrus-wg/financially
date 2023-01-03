import 'package:financially/utils/getLatestPriceInfo.dart';
import 'package:financially/utils/watchlist.dart';

Future<List<dynamic>> getWatchedInfo() async {
  final watchedlist = await getWatchList();
  List<dynamic> list = [];
  for (var item in watchedlist) {
    final i = await getLatestPriceInfo(item);
    list.add(i);
  }
  return list;
}
