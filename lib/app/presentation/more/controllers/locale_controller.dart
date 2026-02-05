import 'package:flutter/material.dart';
import 'package:pubchem/app/core/provider/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_controller.g.dart';

@riverpod
class LocaleController extends _$LocaleController {
  @override
  Locale build() {
    _loadLocale();
    return const Locale('en', ''); // Default to English
  }

  void setLocale(Locale locale) {
    state = locale;
    _saveLocale(locale.languageCode);
  }

  Future<void> _loadLocale() async {
    final getSavedLocaleUseCase = ref.read(getSavedLocaleUseCaseProvider);
    final savedLocale = await getSavedLocaleUseCase();

    if (savedLocale != null) {
      state = savedLocale;
    }
  }

  Future<void> _saveLocale(String languageCode) async {
    final saveLocaleUseCase = ref.read(saveLocaleUseCaseProvider);
    await saveLocaleUseCase(languageCode);
  }
}