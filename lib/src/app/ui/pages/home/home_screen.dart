import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/color/ui_colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UiColors.pageBackground, body: Container());
  }
}
