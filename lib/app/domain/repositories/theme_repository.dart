import 'package:pubchem/app/core/base/app_theme.dart';

abstract class ThemeRepository {
  Future<AppTheme?> getSavedTheme();
  Future<void> saveTheme(AppTheme theme);
}