import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';

List<NewsDataItem> sortBySourceAndDate(
    List<String> queries, Map<String, List<NewsDataItem>> map) {
  List<NewsDataItem> result = [];
  List<int> indexList = List.filled(map.keys.length, 0);
  int fullListLength = 0;
  for (var element in map.values) {
    fullListLength += element.length;
  }

  for (int i = 0; i < fullListLength; i++) {
    for (int j = 0; j < queries.length; j++) {
      if (map[queries[j]]!.length > indexList[j]) {
        result.add(map[queries[j]]![indexList[j]]);
        indexList[j]++;
      }
    }
  }

  return result;
}
