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
}
