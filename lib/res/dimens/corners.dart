import 'package:flutter/widgets.dart';

import 'insets.dart';

class Corners {
  static const double small = 4;
  static const Radius smallRadius = Radius.circular(small);
  static const BorderRadius smallBorder = BorderRadius.all(smallRadius);

  static const double med = 8;
  static const Radius medRadius = Radius.circular(med);
  static const BorderRadius medBorder = BorderRadius.all(medRadius);

  static const double large = 12;
  static const Radius largeRadius = Radius.circular(large);
  static const BorderRadius largeBorder = BorderRadius.all(largeRadius);

  static const double xLarge = 16;
  static const Radius xLargeRadius = Radius.circular(xLarge);
  static const BorderRadius xLargeBorder = BorderRadius.all(xLargeRadius);
  static const BorderRadius xLargeTopBorder =
      BorderRadius.only(topLeft: xLargeRadius, topRight: xLargeRadius);

  static const double xxLarge = 24;
  static const Radius xxLargeRadius = Radius.circular(xxLarge);
  static const BorderRadius xxLargeBorder = BorderRadius.all(xxLargeRadius);

  static BorderRadius bottomSheetTopBorder = BorderRadius.only(
      topLeft: Radius.circular(Insets.lg),
      topRight: Radius.circular(Insets.lg));

  static const double xxxLarge = 36;
  static const BorderRadius xxxLargeBorder = BorderRadius.all(xxxLargeRadius);
  static const Radius xxxLargeRadius = Radius.circular(xxxLarge);
}
