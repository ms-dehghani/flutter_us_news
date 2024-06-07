import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/dimens/insets.dart';
import 'package:flutter_us_news/res/drawable/app_icons.dart';
import 'package:flutter_us_news/res/drawable/item_splitter.dart';
import 'package:flutter_us_news/res/string/texts.dart';
import 'package:flutter_us_news/res/styles/text_style.dart';
import 'package:flutter_us_news/src/app/ui/widgets/buttons/flat_border_button.dart';
import 'package:flutter_us_news/src/app/ui/widgets/image/image_view.dart';
import 'package:flutter_us_news/src/utils/extensions/translates_string_extensions.dart';

class ErrorScreen extends StatefulWidget {
  double width;
  double height;
  Function onReload;

  ErrorScreen(
      {super.key,
      required this.width,
      required this.height,
      required this.onReload});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageView(
            size: Insets.emptyImageSize,
            src: AppIcons.errorImage,
          ),
          ItemSplitter.medSplitter,
          FlatBorderButton(
              onTap: () {
                widget.onReload.call();
              },
              borderColor: UiColors.borderColor,
              rippleColor: UiColors.primaryRipple,
              size: Size(Insets.buttonHeight * 2, Insets.buttonHeight),
              child: Text(
                Texts.reload.translate,
                style: TextStyles.h3.copyWith(color: UiColors.primaryText),
              ))
        ],
      ),
    );
  }
}
