import 'package:flutter/material.dart';
import 'package:pubchem/app/domain/repositories/locale_repository.dart';

class GetSavedLocaleUseCase {
  final LocaleRepository repository;

  GetSavedLocaleUseCase(this.repository);

  Future<Locale?> call() async {
    return await repository.getSavedLocale();
  }
}