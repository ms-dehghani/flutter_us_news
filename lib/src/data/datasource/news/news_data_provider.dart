import 'package:flutter_us_news/src/data/dto/news/news_data_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';

abstract class NewsDataProvider {
  Future<void> addNewsListToCache(List<NewsDataItem> items);

  Future<NewsDataItem?> getNewsDetail(String newsID);

  Future<List<NewsDataItem>> getNewsList(
      {required int from,
      required int to,
      required List<String> queries,
      required SortBy sortBy,
      required int pageNumber});
}
