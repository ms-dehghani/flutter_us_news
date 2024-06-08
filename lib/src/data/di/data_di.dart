import 'package:dio/dio.dart';
import 'package:flutter_us_news/src/base/base_di.dart';
import 'package:flutter_us_news/src/configs.dart';
import 'package:flutter_us_news/src/data/datasource/news/api/news_api_data_provider.dart';
import 'package:flutter_us_news/src/data/datasource/news/db/news_db_data_provider.dart';
import 'package:flutter_us_news/src/data/datasource/webservice/web_service.dart';
import 'package:flutter_us_news/src/data/repositories/news/news_repository_impl.dart';
import 'package:flutter_us_news/src/data/repositories/trend/trend_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class DataDI implements BaseDi {
  final getIt = GetIt.instance;

  @override
  Future<void> provideDependencies() async {
    _provideDio();
    _provideWebService();
    await _provideDatabase();
    _provideNewsRepository();
    _provideTrendRepository();
  }

  void _provideDio() {
    var timeOut = const Duration(seconds: 10);
    Dio dio = Dio(BaseOptions(
        baseUrl: Configs.baseUrl,
        sendTimeout: timeOut,
        receiveTimeout: timeOut,
        connectTimeout: timeOut));

    getIt.registerSingleton<Dio>(dio);
  }

  void _provideWebService() {
    getIt.registerSingleton<WebService>(WebService(getIt()));
  }

  Future<void> _provideDatabase() async {
    var db = await openDatabase('my_db.db');
    getIt.registerSingleton<Database>(db);
  }

  void _provideNewsRepository() {
    var newsApiDataProvider = NewsApiDataProvider(getIt());
    var newsDbDataProvider = NewsDbDataProvider(getIt());

    getIt.registerSingleton<NewsApiDataProvider>(newsApiDataProvider);
    getIt.registerSingleton<NewsDbDataProvider>(newsDbDataProvider);

    var newsRepositoryImpl =
        NewsRepositoryImpl(newsDbDataProvider, newsApiDataProvider);

    getIt.registerSingleton<NewsRepositoryImpl>(newsRepositoryImpl);
  }

  void _provideTrendRepository() {
    getIt.registerSingleton<TrendRepositoryImpl>(TrendRepositoryImpl());
  }
}
