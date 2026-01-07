import 'package:flutter/material.dart';
import 'package:homekru_owner/core/l10n/app_language.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  static const String _localeKey = 'app_locale';

  @override
  Locale build() {
    _loadSavedLocale();
    return const Locale('en', ''); // Default: English
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey);
    if (localeCode != null) {
      state = Locale(localeCode, '');
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    state = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, newLocale.languageCode);
  }

  Future<void> toggleLocale() async {
    final newLocale =
        state.languageCode == 'en'
            ? const Locale('id', '')
            : const Locale('en', '');
    await setLocale(newLocale);
  }

  /// Set locale using AppLanguage enum
  Future<void> setLanguage(AppLanguage language) async {
    await setLocale(language.toLocale);
  }

  AppLanguage currentLanguage() {
    return AppLanguageX.fromLocale(state);
  }
}
