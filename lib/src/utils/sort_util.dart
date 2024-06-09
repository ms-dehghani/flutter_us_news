import 'package:flutter_us_news/src/data/dto/news/db/news_data_item.dart';

List<NewsDataItem> sortBySourceAndDate(
    List<String> queries, Map<String, List<NewsDataItem>> map) {
  List<NewsDataItem> result = [];
  List<int> indexList = List.filled(map.keys.length, 0);
  int fullListLength = 0;
  for (var element in map.values) {
    fullListLength += element.length;
  }

  int sum = 0;
  while (sum < fullListLength) {
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
    if (result.length > 1 &&
        result[result.length - 2].title == maxDataItem.title) {
      result.removeLast();
    }
    indexList[findIndex]++;
    sum++;
  }

  return result;
}
