import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> getLatestPriceInfo(String ticker) async {
  try {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(
        "https://twelve-data1.p.rapidapi.com/quote?interval=1min&symbol=$ticker&format=json&outputsize=30"));
    request.headers.add(
        'X-RapidAPI-Key', '0ad5415f16mshddf80c421caf87ap117549jsnb8764e18895d');
    request.headers.add('X-RapidAPI-Host', 'twelve-data1.p.rapidapi.com');
    HttpClientResponse response = await request.close();
    final d = await response.transform(utf8.decoder).join();
    Map<String, dynamic> data = jsonDecode(d);
    if (data['is_market_open']) {
      HttpClientRequest request2 = await httpClient.getUrl(Uri.parse(
          "https://twelve-data1.p.rapidapi.com/price?symbol=$ticker&outputsize=30&format=json"));
      request2.headers.add('X-RapidAPI-Key',
          '0ad5415f16mshddf80c421caf87ap117549jsnb8764e18895d');
      request2.headers.add('X-RapidAPI-Host', 'twelve-data1.p.rapidapi.com');
      HttpClientResponse response2 = await request2.close();
      final d2 = await response2.transform(utf8.decoder).join();
      Map<String, dynamic> data2 = jsonDecode(d2);
      Map<String, dynamic> c = {...data, ...data2};
      httpClient.close();
      return c;
    }
    httpClient.close();
    data['price'] = data['close'];
    print(data);
    return data;
  } catch (e) {
    print(e);
  }
  return {};
}
