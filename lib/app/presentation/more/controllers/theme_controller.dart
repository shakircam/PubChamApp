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
    _saveTheme(theme.toString());
  }

  Future<void> _loadTheme() async {
    final prefManager = ref.read(prefManagerProvider);
    // TODO: Load theme from storage
    // Example: final savedTheme = await prefManager.getTheme();
    // if (savedTheme != null) state = savedTheme;
  }

  Future<void> _saveTheme(String value) async {
    final prefManager = ref.read(prefManagerProvider);
    // TODO: Save theme to storage
    // Example: await prefManager.saveTheme(value);
  }
}
