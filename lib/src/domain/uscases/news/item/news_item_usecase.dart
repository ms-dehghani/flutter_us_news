import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/domain/repositories/news/item/news_item_repository.dart';

class NewsItemUseCase {
  late final NewsItemRepository _repository;

  NewsItemUseCase({required NewsItemRepository repository}) {
    _repository = repository;
  }

  Future<NewsItem> invoke(String newsID) {
    return _repository.getNewsDetail(newsID);
  }
}
