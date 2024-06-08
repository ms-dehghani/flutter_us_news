import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/repositories/news/item/news_item_repository.dart';
import 'package:flutter_us_news/src/domain/uscases/news/item/news_item_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_item_usecase_test.mocks.dart';

@GenerateMocks([NewsItemRepository])
void main() {
  late NewsItemUseCase usecase;
  late MockNewsItemRepository repository;

  setUpAll(() async {
    repository = MockNewsItemRepository();
    usecase = NewsItemUseCase(repository: repository);
  });

  test("When getNewsDetail then return valid data", () async {
    when(repository.getNewsDetail(any))
        .thenAnswer((realInvocation) => Future.value(NewsItem.empty()));
    var result = await usecase.invoke("");

    expect(result, isNotNull);
    verify(repository.getNewsDetail(any)).called(1);
  });

  test("When getNewsDetail then return error", () async {
    when(repository.getNewsDetail(any))
        .thenAnswer((realInvocation) => Future.error(""));
    try {
      await usecase.invoke("");
    } catch (e) {
      verify(repository.getNewsDetail(any)).called(1);
    }
  });
}
