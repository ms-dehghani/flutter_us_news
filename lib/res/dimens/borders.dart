import 'package:flutter/widgets.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';

import 'corners.dart';
import 'strokes.dart';

class Borders {
  static RoundedRectangleBorder thinAndMedRadiosBorder() =>
      RoundedRectangleBorder(
          borderRadius: Corners.medBorder, side: thinBorder());

  static RoundedRectangleBorder thinAndHighRadiosBorder() =>
      RoundedRectangleBorder(
          borderRadius: Corners.xLargeBorder, side: thinBorder());

  static BorderSide thinBorder() =>
      const BorderSide(width: Strokes.thin, color: UiColors.borderColor);
}
