import 'package:financially/utils/getCompanyName.dart';
import 'package:financially/utils/watchlist.dart';

Future<Map<String, dynamic>> getStocksEntry(String ticker) async {
  String name = await getCompanyName(ticker);
  bool marked = await getWatched(ticker);
  return {'name': name, 'watched': marked};
}
