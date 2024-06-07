import 'package:flutter_us_news/src/domain/dto/trend/trend_item.dart';
import 'package:flutter_us_news/src/domain/repositories/trend/list/trend_list_repository.dart';

class TrendRepositoryImpl implements TrendListRepository {
  TrendRepositoryImpl();

  @override
  Future<List<TrendItem>> getTrendList() {
    List<TrendItem> items = [];
    items.add(TrendItem(
        id: "Crypto",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKkNXlFg0GDjxekZ7Ym100VB6-bU9W98E7ndxUc0t9B8SO6rmSLKpkQxRNNh3znOARRUI&usqp=CAU",
        title: "Crypto"));
    items.add(TrendItem(
        id: "",
        image:
            "https://www.sccm.org/sccm/media/SCCMv2/Blog-Cards-940x450/Blog-Card-COVID-Vaccine.png?ext=.png",
        title: "Covid-19"));
    items.add(TrendItem(
        id: "Environment",
        image:
            "https://www.fastweb.com/uploads/article_photo/photo/2036160/Simple_Environment.jpeg",
        title: "Environment"));
    items.add(TrendItem(
        id: "War",
        image:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Thomas_C._Lea_III_-_That_Two-Thousand_Yard_Stare_-_Original.jpg/220px-Thomas_C._Lea_III_-_That_Two-Thousand_Yard_Stare_-_Original.jpg",
        title: "War"));
    return Future.value(items);
  }
}
