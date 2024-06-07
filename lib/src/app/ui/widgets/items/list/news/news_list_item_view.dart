import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';
import 'package:flutter_us_news/res/drawable/drawable.dart';
import 'package:flutter_us_news/res/styles/text_style.dart';
import 'package:flutter_us_news/src/app/ui/widgets/image/network_image_view.dart';
import 'package:flutter_us_news/src/domain/dto/news/news_item.dart';
import 'package:flutter_us_news/src/utils/time_util.dart';

class NewsListItemView extends StatefulWidget {
  final NewsItem item;
  final Function(NewsItem)? onTap;

  const NewsListItemView({super.key, required this.item, this.onTap});

  @override
  State<NewsListItemView> createState() => _NewsListItemViewState();
}

class _NewsListItemViewState extends State<NewsListItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Drawable.newsListItemDecoration,
      margin: EdgeInsets.symmetric(vertical: Insets.sm),
      padding: EdgeInsets.all(Insets.sm),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _newsImage(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(Insets.sm),
                height: Insets.newsListItemIcon,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_newsTitle(), _newsDetail()],
                ),
              ),
            )
          ],
        ),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!(widget.item);
          }
        },
      ),
    );
  }

  Widget _newsImage() {
    return NetworkImageView(
      image: widget.item.image,
      size: Size(Insets.newsListItemIcon, Insets.newsListItemIcon),
      borderRadius: Insets.med,
    );
  }

  Widget _newsTitle() {
    return Expanded(
        child: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.item.title,
            maxLines: 1,
            style: TextStyles.h2Bold.copyWith(color: UiColors.primaryText),
          ),
          Text(
            widget.item.description,
            maxLines: 2,
            style: TextStyles.h3.copyWith(color: UiColors.primaryText),
          )
        ],
      ),
    ));
  }

  Widget _newsDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(timeToText(widget.item.date),
            maxLines: 1,
            style: TextStyles.h4.copyWith(color: UiColors.secondaryText)),
        Text(widget.item.source,
            maxLines: 1,
            style: TextStyles.h4.copyWith(color: UiColors.secondaryText))
      ],
    );
  }
}
