import 'package:pubchem/app/core/base/app_theme.dart';
import 'package:pubchem/app/domain/repositories/theme_repository.dart';

class GetSavedThemeUseCase {
  final ThemeRepository repository;

  GetSavedThemeUseCase(this.repository);

  Future<AppTheme?> call() async {
    return await repository.getSavedTheme();
  }
}