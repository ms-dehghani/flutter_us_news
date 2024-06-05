import 'package:flutter_us_news/src/base/base_model.dart';
import 'package:flutter_us_news/src/configs.dart';
import 'package:flutter_us_news/src/data/dto/news/news_data_item.dart';
import 'package:flutter_us_news/src/data/dto/news/news_item_static.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:sqflite/sqflite.dart';

import 'cache_validate_data_provider.dart';

class CacheValidateDataProviderImpl extends BaseModel
    implements CacheValidateDataProvider {
  final Database _database;

  final String tableName = "RequestTime";

  static CacheValidateDataProviderImpl? _singleton;

  factory CacheValidateDataProviderImpl(Database database) {
    _singleton ??= CacheValidateDataProviderImpl._internal(database);
    return _singleton!;
  }

  CacheValidateDataProviderImpl._internal(this._database) {
    _database.execute(
        "create table if not exists $tableName (id INTEGER PRIMARY KEY , time INTEGER)");
  }

  Future<void> createOrUpdateNews(int timestamp) async {
    await _database.insert(tableName, {"id": 1, "time": timestamp},
        conflictAlgorithm: ConflictAlgorithm.replace);
    return Future.value();
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
  Future<bool> isCacheValid() async {
    List<Map> list = await _database.query(tableName,
        columns: ["id", "time"], where: "id = ?", whereArgs: [1]);
    if (list.isNotEmpty) {
      return Future.value(
          list[0]["time"] + Configs.cacheValidDuration.inMilliseconds <
              DateTime.now().millisecondsSinceEpoch);
    }
    return Future.value(false);
  }

  @override
  Future<void> updateCacheTime(int time) {
    return createOrUpdateNews(time);
  }
}
