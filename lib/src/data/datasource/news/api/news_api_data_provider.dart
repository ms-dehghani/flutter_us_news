import 'package:dio/dio.dart';
import 'package:flutter_us_news/src/configs.dart';
import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/data/datasource/webservice/web_service.dart';
import 'package:flutter_us_news/src/data/dto/news/news_data_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';

class NewsApiDataProvider extends NewsDataProvider {
  final WebService _webService;

  NewsApiDataProvider(this._webService);

  @override
  Future<NewsDataItem?> getNewsDetail(String newsID) {
    return Future.value(NewsDataItem.empty());
  }

  @override
  Future<List<NewsDataItem>> getNewsList(
      {required int from,
      required int to,
      required List<String> queries,
      required SortBy sortBy,
      required int pageNumber}) async {
    List<Future> webserviceGetList = List.generate(queries.length, (int index) {
      String url = "/everything?q=${queries[index]}"
          "&from=${DateTime.fromMillisecondsSinceEpoch(from).toIso8601String()}"
          "&to=${DateTime.fromMillisecondsSinceEpoch(to).toIso8601String()}"
          "&sortBy=${sortBy.value}"
          "&page=$pageNumber"
          "&pageSize=${Configs.pageSize}";
      // "/everything?q=${queries[index]}&from=${from}&to=${to}&sortBy=${sortBy.value}&page=$pageNumber&pageSize=${Configs.pageSize}&apiKey=${Configs.apiKey}";

      return _webService.get(url);
    });

    try {
      List<NewsDataItem> result = [];
      List responseList = await Future.wait(webserviceGetList);
      for (int index = 0; index < responseList.length; index++) {
        var response = (responseList[index] as Response).data;
        if ((response as Map).containsKey("articles")) {
          for (var (item as Map) in response["articles"]) {
            result.add(NewsDataItem.fromMap(item, queries[index]));
          }
        }
      }
      return Future.value(result);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> addNewsListToCache(List<NewsDataItem> items) {
    throw UnimplementedError();
  }
}
