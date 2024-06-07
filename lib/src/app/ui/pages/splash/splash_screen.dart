import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';
import 'package:flutter_us_news/src/app/ui/pages/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext context;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(
          //   width: getWidth(context),
          //   height: getHeight(context) / 2,
          //   child: Center(
          //     child: ImageView(
          //       src: AppIcons.topSplash,
          //       size: 200,
          //     ),
          //   ),
          // ),
          // SvgPicture.asset(
          //   AppIcons.bottomSplash,
          //   fit: BoxFit.cover,
          // ),
        ],
      ),
    );
  }
}
