import 'package:financially/utils/getCompanyName.dart';
import 'package:financially/utils/getLatestPriceInfo.dart';
import 'package:financially/utils/marked.dart';

Future<Map<String, dynamic>> getStockInfo(String ticker) async {
  Map<String, dynamic> priceInfo = await getLatestPriceInfo(ticker);
  String name = await getCompanyName(ticker);
  bool m = await marked(ticker);
  return {...priceInfo, 'name': name, 'marked': m};
}
