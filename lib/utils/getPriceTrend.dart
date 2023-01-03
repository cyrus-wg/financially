import 'dart:convert';
import 'dart:io';

import 'package:financially/apiKeys.dart';

Future<List<double>> getPriceTrend(String ticker, int duration) async {
  try {
    String key = duration == 1 ? 'Time Series (5min)' : 'Time Series (Daily)';
    late String url;
    if (duration == 1) {
      url =
          'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$ticker&interval=5min&outputsize=full&apikey=$alphavantage';
    } else if (duration > 0 && duration < 100) {
      url =
          'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$ticker&apikey=$alphavantage';
    } else {
      url =
          'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$ticker&outputsize=full&apikey=$alphavantage';
    }

    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    final d = await response.transform(utf8.decoder).join();
    Map<String, dynamic> predata = jsonDecode(d);
    if (predata['Error Message'] != null || predata.isEmpty) {
      // if the ticker is not found
      httpClient.close();
      return [-1];
    }
    Map<String, dynamic> data = predata[key];
    List<String> keys = data.keys.toList();
    List<double> prices = [];
    final int len =
        duration < keys.length || duration == 1 ? keys.length : duration;
    for (int i = 0; i < len; i++) {
      prices.add(double.parse(data[keys[i]]['4. close']));
    }
    httpClient.close();
    List<double> reversedList = List.from(prices.reversed);
    return reversedList;
  } catch (e) {
    print(e);
    return [-2];
  }
}
