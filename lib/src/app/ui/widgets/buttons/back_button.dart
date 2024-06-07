import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/dimens/corners.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';
import 'package:flutter_us_news/res/drawable/app_icons.dart';
import 'package:flutter_us_news/res/drawable/drawable.dart';

import '../image/image_view.dart';

class AppBarBackButton extends StatelessWidget {
  Function() onTap;

  AppBarBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: Insets.backButtonHeight,
        height: Insets.backButtonHeight,
        child: InkWell(
          borderRadius: Corners.xLargeBorder,
          splashColor: UiColors.primary.withOpacity(0.2),
          highlightColor: Colors.transparent,
          onTap: () {
            onTap.call();
          },
          child: Ink(
            decoration: Drawable.backButtonDecoration(),
            child: Container(
              width: Insets.backButtonHeight,
              height: Insets.backButtonHeight,
              padding: EdgeInsets.all(Insets.sm),
              child: RotatedBox(
                quarterTurns: -2,
                child: ImageView(
                  src: AppIcons.back,
                  size: Insets.iconSizeXL,
                  color: UiColors.primaryText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
