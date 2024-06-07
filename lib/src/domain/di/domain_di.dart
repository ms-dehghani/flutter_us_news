import 'package:flutter_us_news/src/base/base_di.dart';
import 'package:flutter_us_news/src/data/repositories/news/news_repository_impl.dart';
import 'package:flutter_us_news/src/data/repositories/trend/trend_repository_impl.dart';
import 'package:flutter_us_news/src/domain/uscases/news/item/news_item_usecase.dart';
import 'package:flutter_us_news/src/domain/uscases/news/list/news_list_usecase.dart';
import 'package:flutter_us_news/src/domain/uscases/trend/list/trend_list_usecase.dart';
import 'package:get_it/get_it.dart';

class DomainDI implements BaseDi {
  final getIt = GetIt.instance;

  @override
  Future<void> provideDependencies() async {
    getIt.registerSingleton<NewsItemUseCase>(
        NewsItemUseCase(repository: getIt<NewsRepositoryImpl>()));

    getIt.registerSingleton<NewsListUseCase>(
        NewsListUseCase(repository: getIt<NewsRepositoryImpl>()));

    getIt.registerSingleton<TrendListUseCase>(
        TrendListUseCase(repository: getIt<TrendRepositoryImpl>()));
  }
}
