import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/domain/repositories/news/list/news_list_repository.dart';

class NewsListUseCase {
  late final NewsListRepository _repository;

  NewsListUseCase({required NewsListRepository repository}) {
    _repository = repository;
  }

  Future<NewsItem> invoke({
    required int from,
    required int to,
    required List<String> queries,
    required SortBy sortBy,
    int pageNumber = 1,
  }) {
    return _repository.getNewsList(
        from: from,
        pageNumber: pageNumber,
        queries: queries,
        sortBy: sortBy,
        to: to);
  }
}
