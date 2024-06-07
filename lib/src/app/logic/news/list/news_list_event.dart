import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';

sealed class NewsListEvent {}

class NewsListRefreshEvent extends NewsListEvent {
  int from;
  int to;
  List<String> queries;
  SortBy sortBy;

  NewsListRefreshEvent(
      {required this.from,
      required this.to,
      required this.queries,
      required this.sortBy});
}

class NewsListGetEvent extends NewsListEvent {
  int from;
  int to;
  List<String> queries;
  SortBy sortBy;

  NewsListGetEvent(
      {required this.from,
      required this.to,
      required this.queries,
      required this.sortBy});
}
