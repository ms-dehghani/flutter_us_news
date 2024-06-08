import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_us_news/src/app/logic/base/page_status.dart';
import 'package:flutter_us_news/src/app/logic/news/list/news_list_bloc.dart';
import 'package:flutter_us_news/src/app/logic/news/list/news_list_event.dart';
import 'package:flutter_us_news/src/app/logic/news/list/news_list_page_data.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:flutter_us_news/src/domain/dto/trend/trend_item.dart';
import 'package:flutter_us_news/src/domain/uscases/news/list/news_list_usecase.dart';
import 'package:flutter_us_news/src/domain/uscases/trend/list/trend_list_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_list_bloc_test.mocks.dart';

@GenerateMocks([NewsListUseCase, TrendListUseCase])
void main() {
  late NewsListBloc bloc;
  late MockTrendListUseCase trendListUseCase;
  late MockNewsListUseCase useCase;

  setUp(() {
    EquatableConfig.stringify = true;
    useCase = MockNewsListUseCase();
    trendListUseCase = MockTrendListUseCase();
    bloc = NewsListBloc(
        newsListUseCase: useCase, trendListUseCase: trendListUseCase);
  });

  blocTest<NewsListBloc, NewsListBlocPageData>(
    "When NewsListRefreshEvent raised Given parameter Then must return failure",
    build: () {
      when(useCase.invoke(
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              pageNumber: captureAnyNamed("pageNumber"),
              from: captureAnyNamed("from"),
              sortBy: captureAnyNamed("sortBy")))
          .thenAnswer((realInvocation) {
        return Future.error("");
      });
      return bloc;
    },
    act: (bloc) {
      bloc.add(NewsListRefreshEvent(
          from: 1, sortBy: SortBy.publishedDate, queries: [], to: 1));
    },
    expect: () {
      return [
        NewsListBlocPageData(
            status: PageStatus.loading, newsList: [], trendList: []),
        NewsListBlocPageData(
            status: PageStatus.failure, newsList: [], trendList: [])
      ];
    },
    verify: (bloc) {
      verify(useCase.invoke(
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              pageNumber: captureAnyNamed("pageNumber"),
              from: captureAnyNamed("from"),
              sortBy: captureAnyNamed("sortBy")))
          .called(1);
    },
  );

  blocTest<NewsListBloc, NewsListBlocPageData>(
    "When NewsListGetEvent raised Given parameter Then must return failure",
    build: () {
      when(useCase.invoke(
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              pageNumber: captureAnyNamed("pageNumber"),
              from: captureAnyNamed("from"),
              sortBy: captureAnyNamed("sortBy")))
          .thenAnswer((realInvocation) {
        return Future.error("");
      });
      return bloc;
    },
    act: (bloc) {
      bloc.add(NewsListGetEvent(
          from: 1, sortBy: SortBy.publishedDate, queries: [], to: 1));
    },
    expect: () {
      return [
        NewsListBlocPageData(
            status: PageStatus.loading, newsList: [], trendList: []),
        NewsListBlocPageData(
            status: PageStatus.failure, newsList: [], trendList: [])
      ];
    },
    verify: (bloc) {
      verify(useCase.invoke(
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              pageNumber: captureAnyNamed("pageNumber"),
              from: captureAnyNamed("from"),
              sortBy: captureAnyNamed("sortBy")))
          .called(1);
    },
  );

  blocTest<NewsListBloc, NewsListBlocPageData>(
    "When NewsListRefreshEvent raised Given parameter Then must return list",
    build: () {
      when(useCase.invoke(
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              pageNumber: captureAnyNamed("pageNumber"),
              from: captureAnyNamed("from"),
              sortBy: captureAnyNamed("sortBy")))
          .thenAnswer((realInvocation) {
        return Future.value([NewsItem.empty()]);
      });
      when(trendListUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value([TrendItem.empty()]);
      });
      return bloc;
    },
    act: (bloc) {
      bloc.add(NewsListRefreshEvent(
          from: 1, sortBy: SortBy.publishedDate, queries: [], to: 1));
    },
    expect: () {
      return [
        NewsListBlocPageData(
            status: PageStatus.loading, newsList: [], trendList: []),
        NewsListBlocPageData(
            status: PageStatus.success,
            newsList: [NewsItem.empty()],
            trendList: [TrendItem.empty()])
      ];
    },
  );

  blocTest<NewsListBloc, NewsListBlocPageData>(
    "When NewsListGetEvent raised Given parameter Then must return list",
    build: () {
      when(useCase.invoke(
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              pageNumber: captureAnyNamed("pageNumber"),
              from: captureAnyNamed("from"),
              sortBy: captureAnyNamed("sortBy")))
          .thenAnswer((realInvocation) {
        return Future.value([NewsItem.empty()]);
      });
      return bloc;
    },
    act: (bloc) {
      bloc.add(NewsListGetEvent(
          from: 1, sortBy: SortBy.publishedDate, queries: [], to: 1));
    },
    expect: () {
      return [
        NewsListBlocPageData(
            status: PageStatus.loading, newsList: [], trendList: []),
        NewsListBlocPageData(
            status: PageStatus.success,
            newsList: [NewsItem.empty()],
            trendList: [])
      ];
    },
  );

  blocTest<NewsListBloc, NewsListBlocPageData>(
    "When NewsListRefreshEvent raised Given parameter Then must return list",
    build: () {
      when(useCase.invoke(
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              pageNumber: captureAnyNamed("pageNumber"),
              from: captureAnyNamed("from"),
              sortBy: captureAnyNamed("sortBy")))
          .thenAnswer((realInvocation) {
        return Future.value([NewsItem.empty()]);
      });
      when(trendListUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value([TrendItem.empty()]);
      });
      return bloc;
    },
    act: (bloc) {
      bloc.emit.call(bloc.state.copyWith(
          status: PageStatus.success,
          newsList: [NewsItem.empty()],
          trendList: [TrendItem.empty()]));
      bloc.add(NewsListGetEvent(
          from: 1, sortBy: SortBy.publishedDate, queries: [], to: 1));
    },
    expect: () {
      return [
        NewsListBlocPageData(
            status: PageStatus.success,
            newsList: [NewsItem.empty()],
            trendList: [TrendItem.empty()]),
        NewsListBlocPageData(
            status: PageStatus.loading,
            newsList: [NewsItem.empty()],
            trendList: [TrendItem.empty()]),
        NewsListBlocPageData(
            status: PageStatus.success,
            newsList: [NewsItem.empty(), NewsItem.empty()],
            trendList: [TrendItem.empty()])
      ];
    },
  );

  group(
      "When NewsListGetEvent raised Given parameter Then must increase page number",
      () {
    int lastPageNumber = 0;
    blocTest<NewsListBloc, NewsListBlocPageData>(
        "When NewsListGetEvent raised Given parameter Then must increase page number",
        build: () {
      when(useCase.invoke(
              to: captureAnyNamed("to"),
              queries: captureAnyNamed("queries"),
              pageNumber: captureAnyNamed("pageNumber"),
              from: captureAnyNamed("from"),
              sortBy: captureAnyNamed("sortBy")))
          .thenAnswer((realInvocation) {
        return Future.value([NewsItem.empty()]);
      });
      when(trendListUseCase.invoke()).thenAnswer((realInvocation) {
        return Future.value([TrendItem.empty()]);
      });
      return bloc;
    }, act: (bloc) {
      lastPageNumber = bloc.pageNumber;
      bloc.emit.call(bloc.state.copyWith(
          status: PageStatus.success,
          newsList: [NewsItem.empty()],
          trendList: [TrendItem.empty()]));
      bloc.add(NewsListGetEvent(
          from: 1, sortBy: SortBy.publishedDate, queries: [], to: 1));
    }, verify: (bloc) {
      expect(bloc.pageNumber > lastPageNumber, true);
      expect(bloc.pageNumber - 1, lastPageNumber);
    });
  });

  tearDown(() {
    bloc.close();
  });
}
