import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/domain/repositories/news/item/news_item_repository.dart';
import 'package:flutter_us_news/src/domain/repositories/news/list/news_list_repository.dart';

class NewsRepositoryImpl implements NewsItemRepository, NewsListRepository {
  NewsDataProvider localDB;
  NewsDataProvider? api;

  NewsRepositoryImpl(this.localDB, this.api);

  @override
  Future<NewsItem> getNewsDetail(String newsID) {
    // TODO: implement getNewsList
    throw UnimplementedError();
  }

  @override
  Future<NewsItem> getNewsList(
      {required int from,
      required int to,
      required List<String> queries,
      required SortBy sortBy,
      required int pageNumber}) {
    // TODO: implement getNewsList
    throw UnimplementedError();
  }
}
