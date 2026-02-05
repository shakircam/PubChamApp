import 'package:pubchem/app/domain/repositories/locale_repository.dart';

class SaveLocaleUseCase {
  final LocaleRepository repository;

  SaveLocaleUseCase(this.repository);

  Future<void> call(String languageCode) async {
    await repository.saveLocale(languageCode);
  }
}