import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:financially/apiKeys.dart';

Future<Map<String, dynamic>> getLatestPriceInfo(String ticker) async {
  try {
    late Map<String, dynamic> res;
    HttpClient httpClient = HttpClient();
    while (true) {
      String key = rapidapi[Random().nextInt(rapidapi.length)];
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://twelve-data1.p.rapidapi.com/quote?interval=1day&symbol=$ticker&format=json&outputsize=30"));
      request.headers.add('X-RapidAPI-Key', key);
      request.headers.add('X-RapidAPI-Host', 'twelve-data1.p.rapidapi.com');
      HttpClientResponse response = await request.close();
      final d = await response.transform(utf8.decoder).join();
      Map<String, dynamic> data = jsonDecode(d);
      if (data['is_market_open'] == null) {
        continue;
      }
      httpClient.close();
      res = data;
      res['price'] = res['close'];
      break;
    }
    if (res['is_market_open']) {
      Map<String, dynamic> r = await getRealTimePrice(ticker);
      res = {...res, ...r};
    }
    return res;
  } catch (e) {
    print(e);
  }
  return {};
}

Future<Map<String, dynamic>> getRealTimePrice(String ticker) async {
  try {
    late Map<String, dynamic> res;
    HttpClient httpClient = HttpClient();
    while (true) {
      String key = rapidapi[Random().nextInt(rapidapi.length)];
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://twelve-data1.p.rapidapi.com/price?symbol=$ticker&outputsize=30&format=json"));
      request.headers.add('X-RapidAPI-Key', key);
      request.headers.add('X-RapidAPI-Host', 'twelve-data1.p.rapidapi.com');
      HttpClientResponse response = await request.close();
      final d = await response.transform(utf8.decoder).join();
      Map<String, dynamic> data = jsonDecode(d);
      if (data['price'] == null) {
        continue;
      }
      httpClient.close();
      res = data;
      break;
    }
    return res;
  } catch (e) {
    print(e);
  }
  return {};
}
