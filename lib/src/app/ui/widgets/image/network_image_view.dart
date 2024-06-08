import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';
import 'package:flutter_us_news/src/app/ui/widgets/progress/in_page_progress.dart';

class NetworkImageView extends StatelessWidget {
  Size size;
  String image;
  double? borderRadius;
  BoxFit? boxFit;

  NetworkImageView(
      {super.key,
      required this.image,
      required this.size,
      this.borderRadius,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? Insets.xs),
      child: CachedNetworkImage(
        imageUrl: image,
        width: size.width,
        height: size.height,
        fit: boxFit ?? BoxFit.cover,
        placeholder: (context, url) {
          return Container(
            width: size.width,
            height: size.height,
            color: UiColors.borderColor,
            child: InPageProgress(),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            width: size.width,
            height: size.height,
            color: UiColors.disableColor,
          );
        },
      ),
    );
  }
}
