import 'package:pubchem/app/core/base/app_theme.dart';
import 'package:pubchem/app/data/datasources/local/preference/pref_manager.dart';
import 'package:pubchem/app/domain/repositories/theme_repository.dart';
import 'package:pubchem/app/utils/constants.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final PrefManager prefManager;

  ThemeRepositoryImpl(this.prefManager);

  @override
  Future<AppTheme?> getSavedTheme() async {
    final savedTheme = await prefManager.getString(theme);

    if (savedTheme != null && savedTheme.isNotEmpty) {
      // Convert string to AppTheme enum
      switch (savedTheme) {
        case 'AppTheme.DARK':
          return AppTheme.DARK;
        case 'AppTheme.LIGHT':
          return AppTheme.LIGHT;
        case 'AppTheme.SYSTEM':
          return AppTheme.SYSTEM;
        default:
          return null;
      }
    }
    return null;
  }

  @override
  Future<void> saveTheme(AppTheme appTheme) async {
    await prefManager.setString(theme, appTheme.toString());
  }
}