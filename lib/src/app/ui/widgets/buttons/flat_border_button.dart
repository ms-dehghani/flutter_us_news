import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/dimens/borders.dart';

class FlatBorderButton extends StatelessWidget {
  Size? size;
  Color? borderColor;
  Color? backColor;
  Color? rippleColor;

  Function()? onTap;

  Widget child;

  FlatBorderButton(
      {super.key,
      required this.child,
      this.size,
      this.borderColor,
      this.backColor,
      this.rippleColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onTap?.call(),
      style: TextButton.styleFrom(
          fixedSize: size,
          backgroundColor: backColor ?? Colors.transparent,
          foregroundColor: rippleColor,
          shape: Borders.thinAndHighRadiosBorder().copyWith(
              side: Borders.thinAndHighRadiosBorder()
                  .side
                  .copyWith(color: borderColor ?? Colors.transparent))),
      child: child,
    );
  }
}
