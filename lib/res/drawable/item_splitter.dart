import 'package:flutter/widgets.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';

class ItemSplitter {
  static Widget ultraThinSplitter = SizedBox(
    width: Insets.xs,
    height: Insets.xs,
  );

  static Widget thinSplitter = SizedBox(
    width: Insets.sm,
    height: Insets.sm,
  );

  static Widget thickSplitter = SizedBox(
    width: Insets.lg,
    height: Insets.lg,
  );

  static Widget ultraThickSplitter = SizedBox(
    width: Insets.d24,
    height: Insets.d24,
  );

  static Widget medSplitter = SizedBox(
    width: Insets.med,
    height: Insets.med,
  );

  static Widget splitter(double value) => SizedBox(
        width: value,
        height: value,
      );
}
