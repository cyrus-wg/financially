import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Stock {
  final String ticker;
  final String name;
  final bool marked;

  Stock(this.ticker, this.name, this.marked);
  // Stock(this.ticker, this.name);

  static Stock fromJson(Map<String, dynamic> json) {
    final user = FirebaseAuth.instance.currentUser;
    bool m = false;

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(user?.phoneNumber)
    //     .get()
    //     .then(((DocumentSnapshot doc) {
    //   final data = doc.data() as Map<String, dynamic>;
    //   List<dynamic> wl = data['watchlist'];
    //   m = wl.contains(json['Ticker']);
    //   print('${json['Ticker']} + ${m}');
    // }));
    // print(m);

    return Stock(json['Ticker'], json['Name'], m);
  }
}
