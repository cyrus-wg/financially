import 'dart:typed_data';

import 'package:financially/utils/getImage.dart';

Future<Map<String, dynamic>> getHotStockInfo(String ticker) async {
  final Uint8List? i = await getImage(ticker);
  return {'image': i};
}
