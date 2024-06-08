import 'package:json_annotation/json_annotation.dart';

part 'news_api_data_item.g.dart';

@JsonSerializable()
class NewsApiDataItem {
  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "author", defaultValue: "")
  final String? author;

  @JsonKey(name: "urlToImage", defaultValue: "")
  final String? image;

  @JsonKey(name: "url", defaultValue: "")
  final String? url;

  @JsonKey(name: "publishedAt")
  final DateTime date;

  NewsApiDataItem(
      {required this.title,
      required this.description,
      this.author,
      this.image,
      this.url,
      required this.date});

  factory NewsApiDataItem.fromJson(Map<String, dynamic> json) =>
      _$NewsApiDataItemFromJson(json);

  Map<String, dynamic> toJson() => _$NewsApiDataItemToJson(this);
}
