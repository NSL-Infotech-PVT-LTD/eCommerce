import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyLocalization {
  final Locale locale;

  MyLocalization(this.locale);

  static MyLocalization? of(BuildContext context) {
    return Localizations.of<MyLocalization>(context, MyLocalization);
  }

  Map<String, String>? _localizeValue;

  Future load() async {
    // print("dbjsgfjsgf ${locale.languageCode}");
    String jsonStringValue =
        await rootBundle.loadString("lib/utils/${locale.languageCode}.json");

    Map<String, dynamic> mappedJson = json.decode(jsonStringValue);

    _localizeValue = mappedJson.map((key, value) => MapEntry(key, value));
  }

  String? getTranslatedValue(String key) {
    return _localizeValue![key];
  }

  //stat
  static const LocalizationsDelegate<MyLocalization> delegate =
      _MyLocalizationDelegate();
}

class _MyLocalizationDelegate extends LocalizationsDelegate<MyLocalization> {
  const _MyLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalization> load(Locale locale) async {
    MyLocalization localization = new MyLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_MyLocalizationDelegate old) => false;
}
