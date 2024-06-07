import 'package:flutter_us_news/res/string/texts.dart';
import 'package:flutter_us_news/src/utils/extensions/translates_string_extensions.dart';

String timeToText(int timestamp, {bool withDay = true}) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return "${Texts.monthName[date.month - 1].translate} ${withDay ? date.day : ""} ${date.year} ${date.hour}:${date.minute}";
}
