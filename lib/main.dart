import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_us_news/res/string/texts.dart';
import 'package:flutter_us_news/src/app/di/di.dart';
import 'package:flutter_us_news/src/app/ui/pages/splash/splash_screen.dart';
import 'package:flutter_us_news/src/base/navigation_service.dart';
import 'package:flutter_us_news/src/utils/ht/html.dart';

import 'applic.dart';
import 'translations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SpecificLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    HtmlFormatter.format();
    super.initState();
    _localeOverrideDelegate = const SpecificLocalizationDelegate(Locale("en"));
    applic.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = SpecificLocalizationDelegate(locale);
    });
  }

  Future<void> initDI() async {
    await DI.instance().provideDependencies();
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: Texts.appName,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        _localeOverrideDelegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      locale: _localeOverrideDelegate.overriddenLocale,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const SplashScreen();
            } else {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
              );
            }
          },
          future: initDI(),
        ),
      ),
    );
  }
}
