import 'package:flutter/material.dart';

enum AppLanguage { english, indonesian }

extension AppLanguageX on AppLanguage {
  String get label {
    switch (this) {
      case AppLanguage.english:
        return 'English';
      case AppLanguage.indonesian:
        return 'Indonesian';
    }
  }

  /// Convert AppLanguage to Locale
  Locale get toLocale {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en', '');
      case AppLanguage.indonesian:
        return const Locale('id', '');
    }
  }

  /// Get language code (for persistence)
  String get languageCode {
    switch (this) {
      case AppLanguage.english:
        return 'en';
      case AppLanguage.indonesian:
        return 'id';
    }
  }

  /// Convert Locale to AppLanguage
  static AppLanguage fromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'id':
        return AppLanguage.indonesian;
      case 'en':
      default:
        return AppLanguage.english;
    }
  }

  /// Convert language code string to AppLanguage
  static AppLanguage fromLanguageCode(String code) {
    switch (code) {
      case 'id':
        return AppLanguage.indonesian;
      case 'en':
      default:
        return AppLanguage.english;
    }
  }
}
