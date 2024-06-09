import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';
import 'package:flutter_us_news/src/utils/sort_util.dart';

void main() {
  test('Check sort', () async {
    var item = NewsDataItem.empty().copyWith(title: "1", date: 1, source: "a");
    var item2 = item.copyWith(title: "2", date: 2, source: "b");
    var item3 = item.copyWith(title: "3", date: 1, source: "c");
    var item4 = item.copyWith(title: "4", date: 3, source: "a");
    var item5 = item.copyWith(title: "5", date: 3, source: "b");

    List<String> queries = ["a", "b", "c"];
    Map<String, List<NewsDataItem>> map = {
      "a": [item4, item],
      "b": [item5, item2],
      "c": [item3],
    };

    var retrieveItem = sortBySourceAndDate(queries, map);

    expect(retrieveItem[0].title, item4.title);
    expect(retrieveItem[1].title, item5.title);
    expect(retrieveItem[2].title, item2.title);
    expect(retrieveItem[3].title, item.title);
    expect(retrieveItem[4].title, item3.title);
  });

  test('Check sort without duplicates', () async {
    var item = NewsDataItem.empty().copyWith(title: "1", date: 1, source: "a");
    var item2 = item.copyWith(title: "2", date: 2, source: "b");
    var item3 = item.copyWith(title: "2", date: 1, source: "c");
    var item4 = item.copyWith(title: "4", date: 3, source: "a");
    var item5 = item.copyWith(title: "5", date: 3, source: "b");

    List<String> queries = ["a", "b", "c"];
    Map<String, List<NewsDataItem>> map = {
      "a": [item4, item],
      "b": [item5, item2],
      "c": [item3],
    };

    var retrieveItem = sortBySourceAndDate(queries, map);

    expect(retrieveItem[0].title, item4.title);
    expect(retrieveItem[1].title, item5.title);
    expect(retrieveItem[2].title, item2.title);
    expect(retrieveItem[3].title, item.title);
  });
}
