import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/domain/repositories/news/list/news_list_repository.dart';
import 'package:flutter_us_news/src/domain/uscases/news/list/news_list_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_list_usecase_test.mocks.dart';

@GenerateMocks([NewsListRepository])
void main() {
  late NewsListUseCase usecase;
  late MockNewsListRepository repository;

  setUpAll(() async {
    repository = MockNewsListRepository();
    usecase = NewsListUseCase(repository: repository);
  });

  test("When getNewsList then return empty list", () async {
    when(repository.getNewsList(
            from: captureAnyNamed("from"),
            pageNumber: captureAnyNamed("pageNumber"),
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.invoke(
        from: 1,
        pageNumber: 1,
        to: 1,
        queries: [],
        sortBy: SortBy.publishedDate);

    expect(result.length, 0);
    verify(repository.getNewsList(
            from: captureAnyNamed("from"),
            pageNumber: captureAnyNamed("pageNumber"),
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            sortBy: captureAnyNamed("sortBy")))
        .called(1);
  });

  test("When getNewsList then return not empty list", () async {
    when(repository.getNewsList(
            from: captureAnyNamed("from"),
            pageNumber: captureAnyNamed("pageNumber"),
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.value([NewsItem.empty()]));
    var result = await usecase.invoke(
        from: 1,
        to: 1,
        queries: [],
        sortBy: SortBy.publishedDate,
        pageNumber: 1);

    expect(result.length, 1);
    verify(repository.getNewsList(
            from: captureAnyNamed("from"),
            pageNumber: captureAnyNamed("pageNumber"),
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            sortBy: captureAnyNamed("sortBy")))
        .called(1);
  });

  test("When getNewsList then return error", () async {
    when(repository.getNewsList(
            from: captureAnyNamed("from"),
            pageNumber: captureAnyNamed("pageNumber"),
            to: captureAnyNamed("to"),
            queries: captureAnyNamed("queries"),
            sortBy: captureAnyNamed("sortBy")))
        .thenAnswer((realInvocation) => Future.value([NewsItem.empty()]));
    try {
      await usecase.invoke(
          from: 1,
          pageNumber: 1,
          to: 1,
          queries: [],
          sortBy: SortBy.publishedDate);
    } catch (e) {
      verify(repository.getNewsList(
              from: captureAnyNamed("from"),
              pageNumber: captureAnyNamed("pageNumber"),
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              sortBy: captureAnyNamed("sortBy")))
          .called(1);
    }
  });
}
