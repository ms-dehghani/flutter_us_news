import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/res/drawable/app_icons.dart';
import 'package:flutter_us_news/res/string/texts.dart';
import 'package:flutter_us_news/res/styles/text_style.dart';
import 'package:flutter_us_news/src/app/ui/pages/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext context;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomeScreen();
          },
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      color: UiColors.pageBackground,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              AppIcons.splashScreen,
              height: 200,
              width: 200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                Texts.appVersion,
                style:
                    TextStyles.h3Bold.copyWith(color: UiColors.secondaryText),
              ),
            ),
          )
        ],
      ),
    );
  }
}
