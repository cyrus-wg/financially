import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> marked(String ticker) async {
  final user = FirebaseAuth.instance.currentUser;
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user?.phoneNumber)
      .get();
  final data = doc.data();
  final watchlist = data!['watchlist'];
  bool contained = watchlist.contains(ticker);
  return contained;
}

Future<void> switchMarked(String ticker, bool marked) async {
  final user = FirebaseAuth.instance.currentUser;
  final firestore =
      FirebaseFirestore.instance.collection('users').doc(user?.phoneNumber);
  if (!marked) {
    await firestore.update({
      'watchlist': FieldValue.arrayUnion([ticker])
    });
  } else {
    await firestore.update({
      'watchlist': FieldValue.arrayRemove([ticker])
    });
  }
}
