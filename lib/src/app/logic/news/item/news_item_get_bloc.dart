import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_us_news/src/domain/uscases/news/item/news_item_usecase.dart';

import '../../base/page_status.dart';
import 'news_item_get_event.dart';
import 'news_item_get_page_data.dart';

class NewsItemGetBloc extends Bloc<GetNewsItemEvent, NewsItemGetBlocPageData> {
  final NewsItemUseCase _newsItemUseCase;

  NewsItemGetBloc({required NewsItemUseCase newsItemUseCase})
      : _newsItemUseCase = newsItemUseCase,
        super(NewsItemGetBlocPageData(status: PageStatus.initial)) {
    on<GetNewsItemEvent>(_getNewsItemDetail);
  }

  Future<void> _getNewsItemDetail(
      GetNewsItemEvent event, Emitter<NewsItemGetBlocPageData> emit) async {
    emit.call(state.copyWith(status: PageStatus.loading));

    var result = _newsItemUseCase.invoke(event.newsItemID);
    await result.then(
      (value) {
        emit.call(state.copyWith(newsItem: value, status: PageStatus.success));
      },
    ).catchError((e) {
      emit.call(state.copyWith(newsItem: null, status: PageStatus.failure));
    });
  }
}
