class Insets {
  static double scale = 1;
  static double offsetScale = 1;

  // Regular paddings
  static double get xs => 4 * scale;

  static double get sm => 8 * scale;

  static double get med => 12 * scale;

  static double get lg => 16 * scale;

  static double get d24 => 24 * scale;

  static double get xl => 32 * scale;

  static double get pagePadding => 20 * scale;

  static double get buttonHeight => 48 * scale;

  static double get backButtonHeight => 38 * scale;

  static double get searchViewHeight => 48 * scale;

  static double get emptyImageSize => 300 * scale;

  static double get appBarHeight => 64 * scale;

  static double get taskActionBarHeight => 64 * scale;

  static double get addCategoryBottomSheetHeight => 160 * scale;

  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;

  static double get iconSizeS => 16 * scale;

  static double get iconSizeM => 18 * scale;

  static double get iconSizeL => 20 * scale;

  static double get iconSizeXL => 24 * scale;

  static double get iconSize2XL => 32 * scale;

  static double get newsListItemIcon => 86 * scale;

  static double get trendListItemWidth => 136 * scale;
  static double get trendListItemHeight => 164 * scale;
}
