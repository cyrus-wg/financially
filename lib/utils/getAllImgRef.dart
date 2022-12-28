import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> getAllImgName() async {
  final storageRef = FirebaseStorage.instance.ref().child('logos');
  final listResult = await storageRef.listAll();
  List<String> tickers = [];
  for (var item in listResult.items) {
    final filename = item.fullPath.substring(6);
    final ticker = filename.replaceAll('.png', '');
    tickers.add(ticker);
  }
  return tickers;
}
