import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubchem/app/presentation/more/controllers/locale_controller.dart';
import 'package:pubchem/app/presentation/more/controllers/theme_controller.dart';
import 'package:pubchem/app/utils/context_ext.dart';
import 'package:pubchem/l10n/app_localizations.dart';
import 'core/base/app_theme.dart';
import 'core/base/app_theme_data.dart';
import 'core/route/app_router.dart';
import 'core/values/app_values.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(context) {
    final currentLocale = ref.watch(localeControllerProvider);

    return ScreenUtilInit(
        designSize: const Size(
          AppValues.defaultScreenWidth,
          AppValues.defaultScreenHeight,
        ),
        splitScreenMode: false,
        minTextAdapt: true,
        useInheritedMediaQuery: false,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
              title: "",
              debugShowCheckedModeBanner: false,
              theme: _getTheme(),
              locale: currentLocale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''), // English
                Locale('bn', ''), // Bengali
              ],
              routerConfig: AppRouter.router);
        });
  }

  ThemeData _getTheme() {
    final currentTheme = ref.watch(themeControllerProvider);

    switch (currentTheme) {
      case AppTheme.DARK:
        return AppThemeData.getDarkTheme();
      case AppTheme.LIGHT:
        return AppThemeData.getLightTheme();
      case AppTheme.SYSTEM:
        return _getThemeSameAsSystem();
    }
  }

  ThemeData _getThemeSameAsSystem() {
    bool isDarkMode = context.isDarkMode;

    return isDarkMode
        ? AppThemeData.getDarkTheme()
        : AppThemeData.getLightTheme();
  }
}
