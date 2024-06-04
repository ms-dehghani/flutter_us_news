import 'package:dio/dio.dart';
import 'package:flutter_us_news/src/data/constants/constants.dart';
import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/data/dto/news/news_data_item.dart';

class NewsApiDataProvider extends NewsDataProvider {
  final Dio _dio;

  NewsApiDataProvider(this._dio);

  @override
  Future<NewsDataItem?> getNewsDetail(String newsID) {
    return Future.value(NewsDataItem.empty());
  }

  @override
  Future<List<NewsDataItem>> getNewsList(
      {required int from,
      required int to,
      required List<String> queries,
      required String sortBy,
      required int pageNumber}) async {
    String url =
        "/everything?q=${queries.join(",")}&from=$from&to=$to&sortBy=$sortBy&page=$pageNumber&pageSize=${Constants.pageSize}&apiKey=${Constants.apiKey}";
    var response = await _dio.get(url);
    int statusCode = (response.statusCode ?? 0);
    if (statusCode >= 200 && statusCode < 300) {
      return Future.value([]);
    } else {
      return Future.error(response.statusMessage ?? Constants.invalidData);
    }
  }
}
