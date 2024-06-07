import 'package:equatable/equatable.dart';

class NewsItem extends Equatable {
  String id;
  final String title;
  final String description;
  final String author;
  final String image;
  final String source;
  final int date;
  final bool seen;

  NewsItem(
      {required this.title,
      required this.image,
      required this.id,
      required this.description,
      required this.author,
      required this.source,
      required this.seen,
      required this.date});

  NewsItem.empty()
      : id = "",
        title = "",
        description = "",
        author = "",
        source = "",
        image = "",
        date = 0,
        seen = false;

  NewsItem copyWith(
      {String? title,
      String? description,
      String? id,
      String? author,
      String? source,
      String? image,
      bool? seen,
      int? date}) {
    return NewsItem(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        date: date ?? this.date,
        source: source ?? this.source,
        description: description ?? this.description,
        seen: seen ?? this.seen,
        image: image ?? this.image);
  }

  @override
  List<Object?> get props => [id, title, description, source];
}
