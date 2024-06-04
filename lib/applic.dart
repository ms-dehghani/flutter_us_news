import 'package:flutter/material.dart';
import 'package:flutter_us_news/res/styles/text_style.dart';

import 'translations.dart';

typedef void LocaleChangeCallback(Locale locale);

class APPLIC {
  final List<String> supportedLanguages = ['en', 'fa'];

  Iterable<Locale> supportedLocales() =>
      supportedLanguages.map<Locale>((lang) => Locale(lang, ''));
  LocaleChangeCallback? onLocaleChanged;

  static String currentLang = "";
  static bool currentThemeIsDark = false;

  static final APPLIC _applic = APPLIC._internal();

  factory APPLIC() {
    return _applic;
  }

  APPLIC._internal();

  static void changeLang(String? text) {
    text ??= applic.supportedLanguages[0];
    if (text == currentLang) {
      return;
    }
    var selectedLocale = Locale(text);
    currentLang = selectedLocale.languageCode;
    Translations.instance().load(selectedLocale);
    textStyles.reloadStyles(selectedLocale);
    _applic.onLocaleChanged?.call(selectedLocale);
  }
}

APPLIC applic = APPLIC();
