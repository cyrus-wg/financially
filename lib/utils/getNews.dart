import 'dart:convert';
import 'dart:io';

import 'package:financially/utils/apiKeys.dart';

Future<List<dynamic>> getNews(String ticker) async {
  try {
    String url =
        'https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=$ticker&limit=200&apikey=alph$alphavantage';
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    final d = await response.transform(utf8.decoder).join();
    Map<String, dynamic> data = jsonDecode(d);
    if (data.isEmpty || data['feed'].isEmpty) {
      httpClient.close();
      return [];
    }
    List allNews = data['feed'];
    List list = [];
    for (var news in allNews) {
      String datetime = news['time_published'];
      String rDT =
          '${datetime.substring(0, 4)}-${datetime.substring(4, 6)}-${datetime.substring(6, 8)} ${datetime.substring(9, 11)}:${datetime.substring(11, 13)}:${datetime.substring(13, 15)}';

      list.add({
        'title': news['title'],
        'url': news['url'],
        'image': news['banner_image'],
        'source': news['source'],
        'datetime': rDT,
      });
    }
    httpClient.close();
    return list;
  } catch (e) {
    print(e);
    return [];
  }
}
