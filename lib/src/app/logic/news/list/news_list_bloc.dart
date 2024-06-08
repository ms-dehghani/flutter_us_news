import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_us_news/src/app/logic/base/page_status.dart';
import 'package:flutter_us_news/src/domain/uscases/news/list/news_list_usecase.dart';
import 'package:flutter_us_news/src/domain/uscases/trend/list/trend_list_usecase.dart';

import 'news_list_event.dart';
import 'news_list_page_data.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListBlocPageData> {
  final NewsListUseCase _newsListUseCase;
  final TrendListUseCase _trendListUseCase;

  int pageNumber = 0;

  NewsListBloc(
      {required NewsListUseCase newsListUseCase,
      required TrendListUseCase trendListUseCase})
      : _newsListUseCase = newsListUseCase,
        _trendListUseCase = trendListUseCase,
        super(NewsListBlocPageData(status: PageStatus.initial)) {
    on<NewsListGetEvent>(_getAllNewsListEvent);
    on<NewsListRefreshEvent>(_refreshNewsListEvent);
  }

  Future<void> _getAllNewsListEvent(
      NewsListGetEvent event, Emitter<NewsListBlocPageData> emit) async {
    if (state.pageStatus == PageStatus.loading) {
      return;
    }
    emit.call(state.copyWith(status: PageStatus.loading));
    pageNumber++;

    var result = _newsListUseCase.invoke(
        from: event.from,
        to: event.to,
        queries: event.queries,
        sortBy: event.sortBy,
        pageNumber: pageNumber);

    await result.then((result) {
      var newList = state.newsList;
      newList.addAll(result);
      emit.call(state.copyWith(newsList: newList, status: PageStatus.success));
    }).catchError((e) {
      emit.call(state.copyWith(status: PageStatus.failure));
    });
  }

  Future<void> _refreshNewsListEvent(
      NewsListRefreshEvent event, Emitter<NewsListBlocPageData> emit) async {
    if (state.pageStatus == PageStatus.loading) {
      return;
    }
    emit.call(state
        .copyWith(newsList: [], trendList: [], status: PageStatus.loading));

    pageNumber = 1;
    var result = _newsListUseCase.invoke(
        from: event.from,
        to: event.to,
        queries: event.queries,
        sortBy: event.sortBy,
        pageNumber: pageNumber);

    await result.then((result) async {
      var trendList = await _trendListUseCase.invoke();
      emit.call(state.copyWith(
          newsList: result, trendList: trendList, status: PageStatus.success));
    }, onError: (e) {
      emit.call(state.copyWith(status: PageStatus.failure));
    });
  }
}
