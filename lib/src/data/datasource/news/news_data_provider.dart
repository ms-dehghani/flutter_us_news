import 'package:flutter_us_news/src/data/dto/news/news_data_item.dart';

abstract class NewsDataProvider {
  Future<NewsDataItem?> getNewsDetail(String newsID);

  Future<List<NewsDataItem>> getNewsList(
      {required int from,
      required int to,
      required List<String> queries,
      required String sortBy,
      required int pageNumber});
}
