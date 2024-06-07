import 'package:flutter_us_news/src/domain/dto/trend/trend_item.dart';
import 'package:flutter_us_news/src/domain/repositories/trend/list/trend_list_repository.dart';

class TrendListUseCase {
  late final TrendListRepository _repository;

  TrendListUseCase({required TrendListRepository repository}) {
    _repository = repository;
  }

  Future<List<TrendItem>> invoke() {
    return _repository.getTrendList();
  }
}
