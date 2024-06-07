import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/dimens/corners.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';
import 'package:flutter_us_news/res/styles/text_style.dart';
import 'package:flutter_us_news/src/app/ui/widgets/image/network_image_view.dart';
import 'package:flutter_us_news/src/domain/dto/trend/trend_item.dart';

class TrendListItemView extends StatefulWidget {
  final TrendItem item;
  final Function(TrendItem)? onTap;

  const TrendListItemView({super.key, required this.item, this.onTap});

  @override
  State<TrendListItemView> createState() => _TrendListItemViewState();
}

class _TrendListItemViewState extends State<TrendListItemView> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Corners.xxLargeBorder,
      child: SizedBox(
        width: Insets.trendListItemWidth,
        height: Insets.trendListItemHeight,
        child: InkWell(
          borderRadius: Corners.xxLargeBorder,
          splashColor: UiColors.primaryRipple,
          child: Stack(
            children: [_trendImage(), _trendTitle()],
          ),
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!(widget.item);
            }
          },
        ),
      ),
    );
  }

  Widget _trendImage() {
    return NetworkImageView(
      image: widget.item.image,
      size: Size(Insets.trendListItemWidth, Insets.trendListItemHeight),
      borderRadius: Corners.xxLarge,
    );
  }

  Widget _trendTitle() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        height: Insets.xl,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black])),
          alignment: Alignment.center,
          child: Text(
            widget.item.title,
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: TextStyles.h3.copyWith(color: UiColors.white),
          ),
        ),
      ),
    );
  }
}
