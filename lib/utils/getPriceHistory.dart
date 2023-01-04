import 'dart:convert';
import 'dart:io';

import 'package:financially/apiKeys.dart';

Future<List> getPricesHistory(String ticker) async {
  try {
    String url =
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$ticker&outputsize=full&apikey=$alphavantage';

    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    final d = await response.transform(utf8.decoder).join();
    Map<String, dynamic> predata = jsonDecode(d);
    if (predata['Error Message'] != null || predata.isEmpty) {
      // if the ticker is not found
      httpClient.close();
      return [];
    }
    Map<String, dynamic> data = predata['Time Series (Daily)'];
    List<String> keys = data.keys.toList();
    List prices = [];
    int len = keys.length;
    for (int i = 0; i < len; i++) {
      prices.add({
        'date': keys[i],
        'open': data[keys[i]]['1. open'],
        'close': data[keys[i]]['4. close'],
        'high': data[keys[i]]['2. high'],
        'low': data[keys[i]]['3. low']
      });
    }
    return prices;
  } catch (e) {
    print(e);
    return [];
  }
}
