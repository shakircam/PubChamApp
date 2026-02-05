import 'package:pubchem/app/core/base/app_theme.dart';
import 'package:pubchem/app/core/provider/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  AppTheme build() {
    _loadTheme();
    return AppTheme.SYSTEM;
  }

  void setTheme(AppTheme theme) {
    state = theme;
    _saveTheme(theme);
  }

  Future<void> _loadTheme() async {
    final getSavedThemeUseCase = ref.read(getSavedThemeUseCaseProvider);
    final savedTheme = await getSavedThemeUseCase();

    if (savedTheme != null) {
      state = savedTheme;
    }
  }

  Future<void> _saveTheme(AppTheme theme) async {
    final saveThemeUseCase = ref.read(saveThemeUseCaseProvider);
    await saveThemeUseCase(theme);
  }
}
