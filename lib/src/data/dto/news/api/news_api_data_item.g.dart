// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_api_data_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsApiDataItem _$NewsApiDataItemFromJson(Map<String, dynamic> json) =>
    NewsApiDataItem(
      title: json['title'] as String,
      description: json['description'] as String,
      author: json['author'] as String? ?? '',
      image: json['urlToImage'] as String? ?? '',
      url: json['url'] as String? ?? '',
      date: DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$NewsApiDataItemToJson(NewsApiDataItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'author': instance.author,
      'urlToImage': instance.image,
      'url': instance.url,
      'publishedAt': instance.date.toIso8601String(),
    };
