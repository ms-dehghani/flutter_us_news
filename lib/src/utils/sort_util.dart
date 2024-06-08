import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';

List<NewsDataItem> sortBySourceAndDate(
    List<String> queries, Map<String, List<NewsDataItem>> map) {
  List<NewsDataItem> result = [];
  List<int> indexList = List.filled(map.keys.length, 0);
  int fullListLength = 0;
  for (var element in map.values) {
    fullListLength += element.length;
  }

  while (result.length < fullListLength) {
    var findIndex = 0;
    var maxDataItem = NewsDataItem.empty();
    for (int j = 0; j < queries.length; j++) {
      if (map[queries[j]]!.length > indexList[j]) {
        if (maxDataItem.date < map[queries[j]]![indexList[j]].date) {
          maxDataItem = map[queries[j]]![indexList[j]];
          findIndex = j;
        }
      }
    }
    result.add(maxDataItem);
    indexList[findIndex]++;
  }

  return result;
}
