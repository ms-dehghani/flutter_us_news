import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';

import 'news_api_data_item.dart';

class NewsApiDataItemMapNewsDataItem {
  static NewsDataItem map(NewsApiDataItem item, String source) {
    return NewsDataItem(
        title: item.title,
        image: item.image ?? "",
        id: 0,
        author: item.author ?? "",
        date: item.date.millisecondsSinceEpoch,
        description: item.description,
        source: source);
  }
}
