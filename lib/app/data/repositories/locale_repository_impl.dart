import 'package:flutter/material.dart';
import 'package:pubchem/app/data/datasources/local/preference/pref_manager.dart';
import 'package:pubchem/app/domain/repositories/locale_repository.dart';
import 'package:pubchem/app/utils/constants.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final PrefManager prefManager;

  LocaleRepositoryImpl(this.prefManager);

  @override
  Future<Locale?> getSavedLocale() async {
    final savedLanguageCode = await prefManager.getString(appLanguage);

    if (savedLanguageCode != null && savedLanguageCode.isNotEmpty) {
      return Locale(savedLanguageCode, '');
    }
    return null;
  }

  @override
  Future<void> saveLocale(String languageCode) async {
    await prefManager.setString(appLanguage, languageCode);
  }
}