enum AppLanguage {
  bn, // Bangla
  en, // English
}

extension AppLanguageTitle on AppLanguage {
  String getTitle() {
    switch (this) {
      case AppLanguage.bn:
        return "🇧🇩 বাংলা";
      case AppLanguage.en:
        return "🇬🇧 English";
      default:
        return "🇧🇩 বাংলা";
    }
  }
}
