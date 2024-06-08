import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_us_news/src/domain/dto/trend/trend_item.dart';
import 'package:flutter_us_news/src/domain/repositories/trend/list/trend_list_repository.dart';
import 'package:flutter_us_news/src/domain/uscases/trend/list/trend_list_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'trend_list_usecase_test.mocks.dart';

@GenerateMocks([TrendListRepository])
void main() {
  late TrendListUseCase usecase;
  late MockTrendListRepository repository;

  setUpAll(() async {
    repository = MockTrendListRepository();
    usecase = TrendListUseCase(repository: repository);
  });

  test("When getTrendList then return empty list", () async {
    when(repository.getTrendList())
        .thenAnswer((realInvocation) => Future.value([]));
    var result = await usecase.invoke();

    expect(result.length, 0);
    verify(repository.getTrendList()).called(1);
  });

  test("When getTrendList then return not empty list", () async {
    when(repository.getTrendList())
        .thenAnswer((realInvocation) => Future.value([TrendItem.empty()]));
    var result = await usecase.invoke();

    expect(result.length, 1);
    verify(repository.getTrendList()).called(1);
  });

  test("When getTrendList then return error", () async {
    when(repository.getTrendList())
        .thenAnswer((realInvocation) => Future.error(""));
    try {
      await usecase.invoke();
    } catch (e) {
      verify(repository.getTrendList()).called(1);
    }
  });
}
