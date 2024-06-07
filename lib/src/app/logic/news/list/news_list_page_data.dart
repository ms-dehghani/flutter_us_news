import 'package:flutter_us_news/src/app/logic/base/page_status.dart';
import 'package:flutter_us_news/src/app/logic/base/parent_page_data.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/dto/trend/trend_item.dart';

class NewsListBlocPageData extends ParentPageData {
  List<NewsItem> newsList;
  List<TrendItem> trendList;

  NewsListBlocPageData(
      {this.newsList = const [],
      this.trendList = const [],
      required PageStatus status})
      : super(pageStatus: status);

  NewsListBlocPageData copyWith(
      {PageStatus? status,
      List<NewsItem>? newsList,
      List<TrendItem>? trendList}) {
    return NewsListBlocPageData(
      newsList: newsList ?? this.newsList,
      trendList: trendList ?? this.trendList,
      status: status ?? pageStatus,
    );
  }

  @override
  List<Object?> get props => [pageStatus, newsList, trendList];
}
