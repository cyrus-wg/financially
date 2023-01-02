import 'dart:convert';
import 'dart:io';

import 'package:financially/apiKeys.dart';

Future<String> getCompanyName(String ticker) async {
  try {
    String name = '';
    String url =
        'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$ticker&apikey=$alphavantage';
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    final d = await response.transform(utf8.decoder).join();
    Map<String, dynamic> predata = jsonDecode(d);
    if (predata.isEmpty || predata['bestMatches'].isEmpty) {
      httpClient.close();
      return name;
    }
    List data = predata['bestMatches'];
    if (data[0]['1. symbol'] == ticker) name = data[0]['2. name'];
    httpClient.close();
    return name;
  } catch (e) {
    print(e);
    return '';
  }
}
