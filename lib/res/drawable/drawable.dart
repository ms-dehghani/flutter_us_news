import 'package:flutter/cupertino.dart';
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
}
