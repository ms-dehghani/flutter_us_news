import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_us_news/src/app/logic/base/page_status.dart';
import 'package:flutter_us_news/src/app/logic/news/item/news_item_get_bloc.dart';
import 'package:flutter_us_news/src/app/logic/news/item/news_item_get_event.dart';
import 'package:flutter_us_news/src/app/logic/news/item/news_item_get_page_data.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/uscases/news/item/news_item_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_item_get_bloc_test.mocks.dart';

@GenerateMocks([NewsItemUseCase])
void main() {
  late NewsItemGetBloc bloc;
  late MockNewsItemUseCase useCase;

  setUp(() {
    EquatableConfig.stringify = true;
    useCase = MockNewsItemUseCase();
    bloc = NewsItemGetBloc(newsItemUseCase: useCase);
  });

  blocTest<NewsItemGetBloc, NewsItemGetBlocPageData>(
    "Given news id then must return failure",
    build: () => bloc,
    act: (bloc) {
      when(useCase.invoke(any)).thenAnswer((realInvocation) {
        return Future.error("");
      });
      bloc.add(GetNewsItemEvent(""));
    },
    expect: () {
      return [
        NewsItemGetBlocPageData(status: PageStatus.loading, newsItem: null),
        NewsItemGetBlocPageData(status: PageStatus.failure, newsItem: null)
      ];
    },
  );

  blocTest<NewsItemGetBloc, NewsItemGetBlocPageData>(
    "Given news id then must return news item",
    build: () => bloc,
    act: (bloc) {
      when(useCase.invoke(any)).thenAnswer((realInvocation) {
        return Future.value(NewsItem.empty());
      });
      bloc.add(GetNewsItemEvent(""));
    },
    expect: () {
      return [
        NewsItemGetBlocPageData(status: PageStatus.loading, newsItem: null),
        NewsItemGetBlocPageData(
            status: PageStatus.success, newsItem: NewsItem.empty())
      ];
    },
  );

  tearDown(() {
    bloc.close();
  });
}
