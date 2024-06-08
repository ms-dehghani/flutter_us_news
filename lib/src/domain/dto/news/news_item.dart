import 'package:equatable/equatable.dart';

class NewsItem extends Equatable {
  String id;
  final String title;
  final String description;
  final String author;
  final String image;
  final String source;
  final String url;
  final int date;

  NewsItem(
      {required this.title,
      required this.image,
      required this.id,
      required this.description,
      required this.author,
      required this.url,
      required this.source,
      required this.date});

  NewsItem.empty()
      : id = "",
        title = "",
        description = "",
        author = "",
        url = "",
        source = "",
        image = "",
        date = 0;

  NewsItem copyWith(
      {String? title,
      String? description,
      String? id,
      String? author,
      String? source,
      String? image,
      String? url,
      int? date}) {
    return NewsItem(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        date: date ?? this.date,
        source: source ?? this.source,
        url: url ?? this.url,
        description: description ?? this.description,
        image: image ?? this.image);
  }

  @override
  List<Object?> get props => [id, title, description, source];
}
