import 'package:faker/faker.dart';
import 'package:flutter_us_news/src/data/datasource/news/db/news_db_data_provider.dart';
import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';
import 'package:flutter_us_news/src/domain/dto/sort/sort_by.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  late NewsDbDataProvider dataProvider;
  late Faker faker;

  setUpAll(() async {
    faker = Faker();
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    dataProvider = NewsDbDataProvider(db);
  });

  tearDown(() {
    dataProvider.clear();
  });

  test('Insert Item', () async {
    var item = NewsDataItem.empty().copyWith(title: "title");

    await dataProvider.createOrUpdateNews(item);
    var retrieveItem = await dataProvider.getNewsDetail(item.id.toString());

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.id, item.id);
    expect(retrieveItem.title, item.title);
    expect(retrieveItem.author, item.author);
    expect(retrieveItem.source, item.source);
    expect(retrieveItem.description, item.description);
  });

  test('Update Item', () async {
    var item = NewsDataItem.empty().copyWith(title: "title");

    await dataProvider.createOrUpdateNews(item);
    item = item.copyWith(description: "description");
    await dataProvider.createOrUpdateNews(item);
    var retrieveItem = await dataProvider.getNewsDetail(item.id.toString());

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.id, item.id);
    expect(retrieveItem.title, item.title);
    expect(retrieveItem.author, item.author);
    expect(retrieveItem.source, item.source);
    expect(retrieveItem.description, item.description);
  });

  test('Get Correct Item', () async {
    var item = NewsDataItem.empty().copyWith(title: "title");
    var item2 = item.copyWith(title: faker.lorem.sentence());
    var item3 = item.copyWith(title: faker.lorem.sentence());

    await dataProvider.createOrUpdateNews(item);
    await dataProvider.createOrUpdateNews(item2);
    await dataProvider.createOrUpdateNews(item3);
    var retrieveItem = await dataProvider.getNewsDetail(item2.id.toString());

    expect(retrieveItem, isNotNull);
    expect(retrieveItem!.id, item2.id);
    expect(retrieveItem.title, item2.title);
    expect(retrieveItem.author, item2.author);
    expect(retrieveItem.source, item2.source);
    expect(retrieveItem.description, item2.description);
  });

  test('Get Incorrect Item', () async {
    var item = NewsDataItem.empty().copyWith(title: "title");

    await dataProvider.createOrUpdateNews(item);
    var retrieveItem = await dataProvider.getNewsDetail("sss");

    expect(retrieveItem, isNull);
  });

  test('Check item list', () async {
    var item =
        NewsDataItem.empty().copyWith(title: "title", date: 1, source: "a");
    var item2 =
        item.copyWith(title: faker.lorem.sentence(), date: 2, source: "b");
    var item3 =
        item.copyWith(title: faker.lorem.sentence(), date: 1, source: "c");
    var item4 =
        item.copyWith(title: faker.lorem.sentence(), date: 3, source: "a");
    var item5 =
        item.copyWith(title: faker.lorem.sentence(), date: 3, source: "b");

    await dataProvider.createOrUpdateNews(item);
    await dataProvider.createOrUpdateNews(item2);
    await dataProvider.createOrUpdateNews(item3);
    await dataProvider.createOrUpdateNews(item4);
    await dataProvider.createOrUpdateNews(item5);
    var retrieveItem = await dataProvider.getNewsList(
        from: 0,
        to: 3,
        pageNumber: 1,
        queries: ["a", "b", "c"],
        sortBy: SortBy.publishedDate);

    expect(retrieveItem, isNotNull);
    expect(retrieveItem.length, 5);

    expect(retrieveItem[0].title, item4.title);
    expect(retrieveItem[1].title, item5.title);
    expect(retrieveItem[2].title, item2.title);
    expect(retrieveItem[3].title, item.title);
    expect(retrieveItem[4].title, item3.title);
  });
}
