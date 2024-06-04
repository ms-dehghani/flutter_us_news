import 'package:flutter_us_news/src/data/dto/news/news_item_static.dart';

class NewsDataItem {
  String id;
  final String title;
  final String description;
  final String author;
  final String image;
  final int date;
  final bool seen;

  NewsDataItem(
      {required this.title,
      required this.image,
      required this.id,
      required this.description,
      required this.author,
      required this.seen,
      required this.date});

  NewsDataItem.empty()
      : id = "",
        title = "",
        description = "",
        author = "",
        image = "",
        date = 0,
        seen = false;

  NewsDataItem.fromMap(Map data)
      : id = data[filedId] ?? "",
        title = data[filedTitle] ?? "",
        description = data[filedDescription] ?? "",
        image = data[filedImage] ?? "",
        author = data[filedAuthor] ?? "",
        date = data[filedDate] ?? 0,
        seen = (data[filedSeen] ?? 1) == 1 ? true : false;

  NewsDataItem copyWith(
      {String? title,
      String? description,
      String? id,
      String? author,
      String? image,
      bool? seen,
      int? date}) {
    return NewsDataItem(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        date: date ?? this.date,
        description: description ?? this.description,
        seen: seen ?? this.seen,
        image: image ?? this.image);
  }

  Map<String, Object?> toMap() {
    return {
      filedId: id,
      filedTitle: title,
      filedDescription: description,
      filedAuthor: author,
      filedImage: image,
      filedDate: date,
      filedSeen: seen ? 1 : 0,
    };
  }
}
