import 'package:flutter_us_news/src/base/base_model.dart';
import 'package:flutter_us_news/src/configs.dart';
import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';
import 'package:flutter_us_news/src/data/dto/news/db/news_item_static.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/utils/sort_util.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbDataProvider extends BaseModel implements NewsDataProvider {
  final Database _database;

  final String tableName = "News";

  static NewsDbDataProvider? _singleton;

  factory NewsDbDataProvider(Database database) {
    _singleton ??= NewsDbDataProvider._internal(database);
    return _singleton!;
  }

  NewsDbDataProvider._internal(this._database) {
    _database.execute(
        "create table if not exists $tableName ($filedId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$filedTitle TEXT, $filedDescription TEXT, $filedSource TEXT, $filedAuthor TEXT, $filedUrl TEXT, $filedImage TEXT, $filedDate INTEGER)");
  }

  Future<NewsDataItem> createOrUpdateNews(NewsDataItem news) async {
    var newsByTitle = await getNewsByTitle(news.title);
    if (newsByTitle == null) {
      int id = await _database.insert(tableName, news.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (news.id == 0) news.id = id;
    }
    return news;
  }

  Future<bool> createOrUpdateNewsList(List<NewsDataItem> news) async {
    for (var element in news) {
      await createOrUpdateNews(element);
    }
    return Future.value(true);
  }

  Future<NewsDataItem?> getNewsByTitle(String title) async {
    List<Map> list = await _database.query(tableName,
        columns: NewsDataItem.empty().toMap().keys.toList(),
        where: "$filedTitle = ?",
        whereArgs: [title],
        limit: 1);
    return list.isEmpty ? null : NewsDataItem.fromMap(list[0], "");
  }

  @override
  Future<NewsDataItem?> getNewsDetail(String newsID) async {
    List<Map> list = await _database.query(tableName,
        columns: NewsDataItem.empty().toMap().keys.toList(),
        where: "$filedId = ?",
        whereArgs: [newsID],
        limit: 1);
    return list.isEmpty ? null : NewsDataItem.fromMap(list[0], "");
  }

  @override
  Future<List<NewsDataItem>> getNewsList(
      {required int from,
      required int to,
      required List<String> queries,
      required SortBy sortBy,
      required int pageNumber}) async {
    Map<String, List<NewsDataItem>> resultMap = {};
    for (int index = 0; index < queries.length; index++) {
      List<NewsDataItem> result = [];
      List<Map> list = await _database.query(
        tableName,
        columns: NewsDataItem.empty().toMap().keys.toList(),
        where: "$filedDate > ? and $filedDate < ? and $filedSource = ?",
        whereArgs: [from, to, queries[index]],
        orderBy: "$filedDate Desc",
        offset: (pageNumber - 1) * Configs.pageSize,
        limit: Configs.pageSize,
      );
      for (var items in list) {
        result.add(NewsDataItem.fromMap(items, queries[index]));
      }
      resultMap.putIfAbsent(queries[index], () => result);
    }
    return Future.value(sortBySourceAndDate(queries, resultMap));
  }

  @override
  Future<void> addNewsListToCache(List<NewsDataItem> news) {
    return createOrUpdateNewsList(news);
  }
}
