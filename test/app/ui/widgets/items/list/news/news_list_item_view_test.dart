import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_us_news/src/app/ui/widgets/items/list/news/news_list_item_view.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';

void main() {
  Widget newsItem(
      {GlobalKey? key, required NewsItem item, Function(NewsItem)? onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: NewsListItemView(
          key: key,
          item: item,
          onTap: onTap,
        ),
      ),
    );
  }

  testWidgets('News item can shown', (tester) async {
    await tester.pumpWidget(newsItem(item: NewsItem.empty()));
  });

  testWidgets('News item can show title', (tester) async {
    await tester
        .pumpWidget(newsItem(item: NewsItem.empty().copyWith(title: "title")));

    var textFind = find.text("title");
    expect(textFind, findsOneWidget);
  });

  testWidgets('News item can show desc', (tester) async {
    await tester.pumpWidget(newsItem(
        item: NewsItem.empty().copyWith(title: "title", description: "desc")));

    var textFind = find.text("desc");
    expect(textFind, findsOneWidget);
  });

  testWidgets('News item can show source', (tester) async {
    await tester.pumpWidget(newsItem(
        item: NewsItem.empty().copyWith(title: "title", source: "source")));

    var textFind = find.text("source");
    expect(textFind, findsOneWidget);
  });
}
