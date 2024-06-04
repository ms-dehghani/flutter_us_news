import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/dimens/font_size.dart';
import 'package:flutter_us_news/res/font/fonts.dart';

class TextStyles {
  static final TextStyles _textStyles = TextStyles._internal();

  factory TextStyles() {
    return _textStyles;
  }

  TextStyles._internal();

  void reloadStyles(Locale locale) {
    baseFont = const TextStyle(
        fontFamily: Fonts.roboto,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none);
  }

  static TextStyle baseFont = const TextStyle(
      fontFamily: Fonts.roboto,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static TextStyle get h1 => baseFont.copyWith(
        fontWeight: FontWeight.normal,
        fontSize: FontSizes.s20,
        letterSpacing: -1,
      );

  static TextStyle get h1Bold => baseFont.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: FontSizes.s20,
        letterSpacing: -1,
      );

  static TextStyle get h2 =>
      h1.copyWith(fontSize: FontSizes.s16, letterSpacing: -.5);

  static TextStyle get h2Bold =>
      h1Bold.copyWith(fontSize: FontSizes.s16, letterSpacing: -.5);

  static TextStyle get h3 =>
      h1.copyWith(fontSize: FontSizes.s14, letterSpacing: -.05);

  static TextStyle get h3Bold =>
      h2Bold.copyWith(fontSize: FontSizes.s14, letterSpacing: -.05);

  static TextStyle get h4 =>
      h1.copyWith(fontSize: FontSizes.s10, letterSpacing: -.05);

  static TextStyle get h4Bold =>
      h2Bold.copyWith(fontSize: FontSizes.s10, letterSpacing: -.05);
}

TextStyles textStyles = TextStyles();
