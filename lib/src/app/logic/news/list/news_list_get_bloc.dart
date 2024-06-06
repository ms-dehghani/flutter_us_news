import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_us_news/src/app/logic/base/page_status.dart';
import 'package:flutter_us_news/src/domain/uscases/news/list/news_list_usecase.dart';

import 'news_list_get_event.dart';
import 'news_list_get_page_data.dart';

class NewsListGetEventGetBloc
    extends Bloc<NewsListGetEvent, NewsListGetBlocPageData> {
  final NewsListUseCase _newsListUseCase;

  NewsListGetEventGetBloc({required NewsListUseCase newsListUseCase})
      : _newsListUseCase = newsListUseCase,
        super(NewsListGetBlocPageData(status: PageStatus.initial)) {
    on<NewsListGetEvent>(_getAllDayNewsListGetEvent);
  }

  Future<void> _getAllDayNewsListGetEvent(
      NewsListGetEvent event, Emitter<NewsListGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    var result = _newsListUseCase.invoke(
        from: event.from,
        to: event.to,
        queries: event.queries,
        sortBy: event.sortBy,
        pageNumber: event.pageNumber,
        forceRefresh: event.forceRefresh);

    result.then((result) {
      emit.call(state.copyWith(newsList: result, status: PageStatus.success));
    }).catchError((e) {
      emit.call(state.copyWith(status: PageStatus.failure));
    });
  }
}
