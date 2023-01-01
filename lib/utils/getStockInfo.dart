import 'package:financially/utils/getCompanyName.dart';
import 'package:financially/utils/getLatestPriceInfo.dart';

Future<Map<String, dynamic>> getStockInfo(String ticker) async {
  Map<String, dynamic> priceInfo = await getLatestPriceInfo(ticker);
  String name = await getCompanyName(ticker);
  return {...priceInfo, 'name': name};
}
