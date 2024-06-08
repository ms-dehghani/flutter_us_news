import 'news_item_static.dart';

class NewsDataItem {
  int id;
  final String title;
  final String description;
  final String author;
  final String image;
  final String source;
  final int date;

  NewsDataItem(
      {required this.title,
      required this.image,
      required this.id,
      required this.description,
      required this.author,
      required this.source,
      required this.date});

  NewsDataItem.empty()
      : id = 0,
        title = "",
        description = "",
        author = "",
        source = "",
        image = "",
        date = 0;

  NewsDataItem.fromMap(Map data, String source)
      : id = data[filedId] ?? 0,
        title = data[filedTitle] ?? "",
        description = data[filedDescription] ?? "",
        image = data[filedImage] ?? "",
        author = data[filedAuthor] ?? "",
        source = source.isNotEmpty ? source : data[filedSource] ?? source,
        date = data[filedDate] ?? 0;

  NewsDataItem copyWith(
      {String? title,
      String? description,
      int? id,
      String? author,
      String? source,
      String? image,
      int? date}) {
    return NewsDataItem(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        date: date ?? this.date,
        source: source ?? this.source,
        description: description ?? this.description,
        image: image ?? this.image);
  }

  Map<String, Object?> toMap() {
    return {
      filedId: id == 0 ? null : id,
      filedTitle: title,
      filedDescription: description,
      filedAuthor: author,
      filedSource: source,
      filedImage: image,
      filedDate: date
    };
  }
}
