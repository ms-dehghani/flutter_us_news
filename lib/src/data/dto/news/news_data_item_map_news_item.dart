import 'package:flutter_us_news/src/data/dto/news/news_data_item.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';

class NewsDataItemMapNewsItem {
  static NewsItem map(NewsDataItem item) {
    return NewsItem(
        description: "",
        date: 0,
        author: "",
        title: "",
        image: "",
        id: '',
        source: '',
        seen: false);
  }
}
