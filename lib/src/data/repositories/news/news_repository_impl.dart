import 'package:flutter_us_news/src/data/constants/constants.dart';
import 'package:flutter_us_news/src/data/datasource/cache/cache_validate_data_provider.dart';
import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/data/dto/news/news_data_item_map_news_item.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/domain/repositories/news/item/news_item_repository.dart';
import 'package:flutter_us_news/src/domain/repositories/news/list/news_list_repository.dart';

class NewsRepositoryImpl implements NewsItemRepository, NewsListRepository {
  NewsDataProvider localDB;
  NewsDataProvider api;
  CacheValidateDataProvider cacheValidate;

  NewsRepositoryImpl(this.localDB, this.api, this.cacheValidate);

  @override
  Future<NewsItem> getNewsDetail(String newsID) async {
    return Future.value(NewsItem(
        title: "title",
        image:
            "https://st.depositphotos.com/2274151/4841/i/450/depositphotos_48410095-stock-photo-sample-blue-square-grungy-stamp.jpg",
        description: "description",
        author: "author",
        date: 0,
        id: 's',
        source: 's',
        seen: false));
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
      bool forceRefresh = false}) async {
    List<NewsItem> result = [];
    // var isCacheValid = await cacheValidate.isCacheValid();
    // if (!isCacheValid || forceRefresh) {
    //   var newsApiList = await api.getNewsList(
    //       from: from,
    //       to: to,
    //       queries: queries,
    //       sortBy: sortBy,
    //       pageNumber: pageNumber);
    //   await localDB.addNewsListToCache(newsApiList);
    //   await cacheValidate
    //       .updateCacheTime(DateTime.now().millisecondsSinceEpoch);
    // }
    //
    // var newsList = await localDB.getNewsList(
    //     from: from,
    //     to: to,
    //     queries: queries,
    //     sortBy: sortBy,
    //     pageNumber: pageNumber);
    // for (var item in newsList) {
    //   result.add(NewsDataItemMapNewsItem.map(item));
    // }
    await Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < 20; i++) {
      result.add(NewsItem(
          title: "$pageNumber$i",
          image:
              "https://st.depositphotos.com/2274151/4841/i/450/depositphotos_48410095-stock-photo-sample-blue-square-grungy-stamp.jpg",
          description: "description",
          author: "author",
          date: 0,
          id: 's',
          source: 's',
          seen: false));
    }
    return Future.value(_sortBySourceAndDate(queries, result));
  }

  List<NewsItem> _sortBySourceAndDate(
      List<String> sortPriority, List<NewsItem> items) {
    return items;
  }
}
