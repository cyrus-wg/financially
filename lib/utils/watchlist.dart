import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<dynamic>> getWatchList() async {
  final user = FirebaseAuth.instance.currentUser;
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user?.phoneNumber)
      .get();
  final data = doc.data();
  final watchlist = data!['watchlist'];
  return watchlist;
}

Future<bool> getWatched(String ticker) async {
  final watchlist = await getWatchList();
  bool contained = watchlist.contains(ticker);
  return contained;
}

Future<void> switchWatched(String ticker) async {
  final user = FirebaseAuth.instance.currentUser;
  final firestore =
      FirebaseFirestore.instance.collection('users').doc(user?.phoneNumber);
  bool watched = await getWatched(ticker);
  if (!watched) {
    await firestore.update({
      'watchlist': FieldValue.arrayUnion([ticker])
    });
  } else {
    await firestore.update({
      'watchlist': FieldValue.arrayRemove([ticker])
    });
  }
}
