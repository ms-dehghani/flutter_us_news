import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';

abstract class NewsItemRepository {
  Future<NewsItem> getNewsDetail(String newsID);
}
