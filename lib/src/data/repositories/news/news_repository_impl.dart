import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_us_news/src/data/constants/constants.dart';
import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';
import 'package:flutter_us_news/src/data/dto/news/db/news_data_item_map_news_item.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/domain/repositories/news/item/news_item_repository.dart';
import 'package:flutter_us_news/src/domain/repositories/news/list/news_list_repository.dart';

class NewsRepositoryImpl implements NewsItemRepository, NewsListRepository {
  NewsDataProvider localDB;
  NewsDataProvider api;

  NewsRepositoryImpl(this.localDB, this.api);

  @override
  Future<NewsItem> getNewsDetail(String newsID) async {
    var cacheItem = await localDB.getNewsDetail(newsID);
    if (cacheItem != null) {
      return Future.value(NewsDataItemMapNewsItem.map(cacheItem));
    } else {
      cacheItem = (await api.getNewsDetail(newsID));
      if (cacheItem != null) {
        return Future.value(NewsDataItemMapNewsItem.map(cacheItem));
      } else {
        return Future.error(Exception(Constants.itemNotFound));
      }
    }
  }

  @override
  Future<List<NewsItem>> getNewsList(
      {required int from,
      required int to,
      required List<String> queries,
      required SortBy sortBy,
      required int pageNumber,
      String lastNewsId = ""}) async {
    List<NewsDataItem> newsList = [];
    List<NewsItem> result = [];

    try {
      newsList = await api.getNewsList(
          from: from,
          to: to,
          queries: queries,
          sortBy: sortBy,
          pageNumber: pageNumber);
      await localDB.addNewsListToCache(newsList);
    } catch (error) {
      if (error is DioException && error.error is SocketException) {
        newsList = await localDB.getNewsList(
            from: from,
            to: to,
            queries: queries,
            sortBy: sortBy,
            pageNumber: pageNumber);
      } else {
        return Future.error(error);
      }
    }

    for (var item in newsList) {
      result.add(NewsDataItemMapNewsItem.map(item));
    }
    return Future.value(_sortBySourceAndDate(queries, result));
  }

  List<NewsItem> _sortBySourceAndDate(
      List<String> sortPriority, List<NewsItem> items) {
    return items;
  }
}
