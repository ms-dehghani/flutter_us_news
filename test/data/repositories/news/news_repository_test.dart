import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_us_news/src/data/datasource/news/news_data_provider.dart';
import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';
import 'package:flutter_us_news/src/data/repositories/news/news_repository_impl.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_repository_test.mocks.dart';

@GenerateMocks([NewsDataProvider])
void main() {
  late NewsRepositoryImpl repository;
  late MockNewsDataProvider dataProviderDb;
  late MockNewsDataProvider dataProviderApi;

  setUpAll(() async {
    dataProviderDb = MockNewsDataProvider();
    dataProviderApi = MockNewsDataProvider();
    repository = NewsRepositoryImpl(dataProviderDb, dataProviderApi);
  });

  test("When getNewsDetail then return valid data", () async {
    when(dataProviderDb.getNewsDetail(any))
        .thenAnswer((realInvocation) => Future.value(NewsDataItem.empty()));
    var result = await repository.getNewsDetail("");

    expect(result, isNotNull);
    verify(dataProviderDb.getNewsDetail("")).called(1);
  });

  test("When getNewsDetail then return null from db and return error",
      () async {
    when(dataProviderDb.getNewsDetail(any))
        .thenAnswer((realInvocation) => Future.value(null));
    try {
      await repository.getNewsDetail("");
    } catch (e) {
      verify(dataProviderDb.getNewsDetail("")).called(1);
    }
  });

  test("When getNewsDetail then return error", () async {
    when(dataProviderDb.getNewsDetail(""))
        .thenAnswer((realInvocation) => Future.error(""));
    try {
      await repository.getNewsDetail("");
    } catch (e) {
      verify(dataProviderDb.getNewsDetail("")).called(1);
    }
  });

  test("When getNewsList then api send empty list from db", () async {
    when(dataProviderDb.getNewsList(
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            pageNumber: captureAnyNamed("pageNumber"),
            from: captureAnyNamed("from"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.value([]));
    when(dataProviderApi.getNewsList(
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            pageNumber: captureAnyNamed("pageNumber"),
            from: captureAnyNamed("from"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.value([]));

    var result = await repository.getNewsList(
        from: 1,
        sortBy: SortBy.publishedDate,
        pageNumber: 1,
        queries: [],
        to: 1);

    expect(result.length, 0);
  });

  test(
      "When getNewsList then api send SocketException and get empty list from db",
      () async {
    when(dataProviderDb.getNewsList(
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            pageNumber: captureAnyNamed("pageNumber"),
            from: captureAnyNamed("from"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.value([]));
    when(dataProviderApi.getNewsList(
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            pageNumber: captureAnyNamed("pageNumber"),
            from: captureAnyNamed("from"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.error(DioException(
            error: const SocketException(""),
            requestOptions: RequestOptions())));
    var result = await repository.getNewsList(
        from: 1,
        sortBy: SortBy.publishedDate,
        pageNumber: 1,
        queries: [],
        to: 1);

    expect(result.length, 0);
  });

  test("When getNewsList then api send exception and return error", () async {
    when(dataProviderDb.getNewsList(
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            pageNumber: captureAnyNamed("pageNumber"),
            from: captureAnyNamed("from"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.value([]));
    when(dataProviderApi.getNewsList(
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            pageNumber: captureAnyNamed("pageNumber"),
            from: captureAnyNamed("from"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.error(Exception("ex")));
    try {
      await repository.getNewsList(
          from: 1,
          sortBy: SortBy.publishedDate,
          pageNumber: 1,
          queries: [],
          to: 1);
    } catch (e) {
      expect(e is Exception, true);
    }
  });
}
