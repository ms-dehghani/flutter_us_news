import 'package:flutter_us_news/src/base/base_model.dart';
import 'package:flutter_us_news/src/configs.dart';
import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/data/dto/news/news_data_item.dart';
import 'package:flutter_us_news/src/data/dto/news/news_item_static.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
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
        "create table if not exists $tableName ($filedId TEXT PRIMARY KEY,"
        "$filedTitle TEXT, $filedDescription TEXT, $filedSource TEXT, $filedAuthor TEXT, $filedImage TEXT, $filedDate INTEGER, $filedSeen INTEGER)");
  }

  Future<NewsDataItem> createOrUpdateNews(NewsDataItem news) async {
    int id = await _database.insert(tableName, news.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    if (news.id.isEmpty) news.id = id.toString();
    return news;
  }

  Future<bool> createOrUpdateNewsList(List<NewsDataItem> news) {
    for (var element in news) {
      createOrUpdateNews(element);
    }
    return Future.value(true);
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
    List<NewsDataItem> result = [];
    List<Map> list = await _database.query(
      tableName,
      columns: NewsDataItem.empty().toMap().keys.toList(),
      where: "$filedId > ? and $filedId < ? ",
      whereArgs: [from, to],
      limit: Configs.pageSize,
      offset: pageNumber,
      orderBy: "$filedId ASC",
    );
    for (var items in list) {
      result.add(NewsDataItem.fromMap(items, ""));
    }
    return result;
  }

  @override
  Future<void> addNewsListToCache(List<NewsDataItem> news) {
    return createOrUpdateNewsList(news);
  }
}
