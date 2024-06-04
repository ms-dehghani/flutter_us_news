import 'package:flutter_us_news/translations.dart';

extension Translate on String {
  String get translate => Translations.instance().text(this);
}
