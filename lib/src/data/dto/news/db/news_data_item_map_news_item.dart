import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';

class NewsDataItemMapNewsItem {
  static NewsItem map(NewsDataItem item) {
    return NewsItem(
        description: item.description,
        date: item.date,
        author: item.author,
        title: item.title,
        image: item.image,
        id: item.id.toString(),
        url: item.url,
        source: item.source);
  }
}
