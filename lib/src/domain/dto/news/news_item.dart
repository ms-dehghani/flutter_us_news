import 'package:equatable/equatable.dart';

class NewsItem extends Equatable {
  final String title;
  final String description;
  final String author;
  final String image;
  final int date;

  const NewsItem(
      {required this.title,
      required this.image,
      required this.description,
      required this.author,
      required this.date});

  NewsItem copyWith(
      {String? title,
      String? description,
      String? author,
      String? image,
      int? date}) {
    return NewsItem(
        title: title ?? this.title,
        author: author ?? this.author,
        date: date ?? this.date,
        description: description ?? this.description,
        image: image ?? this.image);
  }

  @override
  List<Object?> get props => [title, image, description, author, date];
}
