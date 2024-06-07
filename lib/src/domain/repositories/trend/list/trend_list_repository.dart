import 'package:flutter_us_news/src/domain/dto/trend/trend_item.dart';

abstract class TrendListRepository {
  Future<List<TrendItem>> getTrendList();
}
