import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';

class NewsListGetEvent {
  int from;
  int to;
  List<String> queries;
  SortBy sortBy;
  int pageNumber;
  bool forceRefresh;

  NewsListGetEvent(
      {required this.from,
      required this.to,
      required this.queries,
      required this.sortBy,
      this.pageNumber = 1,
      this.forceRefresh = false});
}
