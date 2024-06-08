import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/dimens/corners.dart';
import 'package:flutter_us_news/res/dimens/strokes.dart';

import 'shadows.dart';

class Drawable {
  static BoxDecoration simpleRoundCorner(Color color) => BoxDecoration(
        color: color,
        borderRadius: Corners.largeBorder,
      );

  static BoxDecoration simpleBorder = BoxDecoration(
      color: UiColors.itemFillColor,
      borderRadius: Corners.largeBorder,
      border: Border.all(color: UiColors.borderColor, width: Strokes.thin));

  static BoxDecoration itemDetailDecoration =
      BoxDecoration(color: UiColors.itemFillColor, boxShadow: Shadows.small);

  static BoxDecoration newsListItemDecoration = BoxDecoration(
      color: UiColors.itemFillColor,
      borderRadius: Corners.xLargeBorder,
      boxShadow: Shadows.small);

  static BoxDecoration searchEdittextDecoration = const BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: Corners.xLargeBorder,
    color: UiColors.itemFillColor,
  );

  static BoxDecoration trendListItemDecoration =
      const BoxDecoration(borderRadius: Corners.xxLargeBorder);

  static BoxDecoration backButtonDecoration() => BoxDecoration(
      color: UiColors.pageBackground,
      borderRadius: Corners.largeBorder,
      border: Border.all(color: UiColors.borderColor, width: Strokes.thin));
}
