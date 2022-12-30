import 'dart:typed_data';

import 'package:financially/utils/getImage.dart';
import 'package:financially/utils/getLatestPriceInfo.dart';

Future<Map<String, dynamic>> getHotCard(String ticker) async {
  final Map<String, dynamic> priceInfo = await getLatestPriceInfo(ticker);
  final Uint8List? image = await getImage(ticker);
  Map<String, dynamic> img = {'image': image};
  Map<String, dynamic> result = {...priceInfo, ...img};
  return result;
}
