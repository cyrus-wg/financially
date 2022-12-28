import 'dart:typed_data';

import 'package:financially/utils/getImage.dart';
import 'package:financially/utils/marked.dart';

Future<Map<String, dynamic>> getWelcomeInfo(String ticker) async {
  final bool m = await marked(ticker);
  final Uint8List? i = await getImage(ticker);
  return {'marked': m, 'image': i};
}
