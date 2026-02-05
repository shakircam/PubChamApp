import 'package:pubchem/app/core/base/app_theme.dart';
import 'package:pubchem/app/domain/repositories/theme_repository.dart';

class SaveThemeUseCase {
  final ThemeRepository repository;

  SaveThemeUseCase(this.repository);

  Future<void> call(AppTheme theme) async {
    await repository.saveTheme(theme);
  }
}