import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

Future<Uint8List?> getImage(String ticker) async {
  final Uint8List? downloadURL = await FirebaseStorage.instance
      .ref()
      .child('logos/$ticker.png')
      .getData(1024 * 1024);
  return downloadURL;
}
