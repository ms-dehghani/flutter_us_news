import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';

import '../../base/page_status.dart';
import '../../base/parent_page_data.dart';

class NewsItemGetBlocPageData extends ParentPageData {
  NewsItem? newsItem;

  NewsItemGetBlocPageData({this.newsItem, required PageStatus status})
      : super(pageStatus: status);

  NewsItemGetBlocPageData copyWith({
    PageStatus? status,
    NewsItem? newsItem,
  }) {
    return NewsItemGetBlocPageData(
      newsItem: newsItem ?? this.newsItem,
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus, newsItem];
}
