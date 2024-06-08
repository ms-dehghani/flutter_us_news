import 'package:flutter_us_news/src/base/base_model.dart';
import 'package:flutter_us_news/src/configs.dart';
import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/data/datasource/webservice/web_service.dart';
import 'package:flutter_us_news/src/data/dto/news/api/news_api_data_item.dart';
import 'package:flutter_us_news/src/data/dto/news/api/news_api_data_item_map_news_data_item.dart';
import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/utils/sort_util.dart';

class NewsApiDataProvider extends BaseModel implements NewsDataProvider {
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

      return _webService.get(url);
    });

    try {
      Map<String, List<NewsDataItem>> resultMap = {};
      List responseList = await Future.wait(webserviceGetList);
      for (int index = 0; index < responseList.length; index++) {
        List<NewsDataItem> result = [];
        var response = responseList[index];
        if ((response as Map).containsKey("articles")) {
          for (var (item as Map<String, dynamic>) in response["articles"]) {
            try {
              result.add(NewsApiDataItemMapNewsDataItem.map(
                  NewsApiDataItem.fromJson(item), queries[index]));
            } catch (e) {}
          }
          resultMap.putIfAbsent(queries[index], () => result);
        }
      }
      return Future.value(sortBySourceAndDate(queries, resultMap));
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> addNewsListToCache(List<NewsDataItem> items) {
    throw UnimplementedError();
  }
}
