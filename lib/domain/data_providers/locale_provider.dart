import 'dart:ui';

class LocaleProvider {
  Locale? _locale;
  Locale get locale => _locale ?? const Locale('en', 'US');

  bool updateLocale(Locale locale) {
    final shouldUpdate = _locale != locale;
    if (shouldUpdate) _locale = locale;
    return shouldUpdate;
  }
}
