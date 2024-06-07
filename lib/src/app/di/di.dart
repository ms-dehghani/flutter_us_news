import 'package:flutter_us_news/src/base/base_di.dart';
import 'package:flutter_us_news/src/data/datasource/news/api/news_api_data_provider.dart';
import 'package:flutter_us_news/src/data/di/data_di.dart';
import 'package:flutter_us_news/src/domain/di/domain_di.dart';
import 'package:flutter_us_news/src/domain/uscases/news/list/news_list_usecase.dart';
import 'package:flutter_us_news/src/domain/uscases/trend/list/trend_list_usecase.dart';
import 'package:get_it/get_it.dart';

class DI implements BaseDi {
  static final DI _singleton = DI._internal();

  static DI instance() {
    return _singleton;
  }

  DI._internal();

  final getIt = GetIt.instance;

  @override
  Future<bool> provideDependencies() async {
    await DataDI().provideDependencies();
    await DomainDI().provideDependencies();
    return Future.value(true);
  }

  NewsApiDataProvider getNewsApiDataProvider() {
    return getIt<NewsApiDataProvider>();
  }

  NewsListUseCase getNewsListUseCase() {
    return getIt<NewsListUseCase>();
  }

  TrendListUseCase getTrendListUseCase() {
    return getIt<TrendListUseCase>();
  }
}
