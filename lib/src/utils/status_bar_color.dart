import 'package:flutter/services.dart';

void setStatusBarColor(Color color, {Brightness brightness = Brightness.dark}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color, statusBarIconBrightness: brightness));
}
