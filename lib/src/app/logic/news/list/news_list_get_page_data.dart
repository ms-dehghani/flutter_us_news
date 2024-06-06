import 'package:flutter_us_news/src/app/logic/base/page_status.dart';
import 'package:flutter_us_news/src/app/logic/base/parent_page_data.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';

class NewsListGetBlocPageData extends ParentPageData {
  List<NewsItem> newsList;

  NewsListGetBlocPageData(
      {this.newsList = const [], required PageStatus status})
      : super(pageStatus: status);

  NewsListGetBlocPageData copyWith(
      {PageStatus? status, List<NewsItem>? newsList}) {
    return NewsListGetBlocPageData(
      newsList: newsList ?? this.newsList,
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus, newsList];
}
