import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubchem/app/presentation/more/controllers/theme_controller.dart';
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
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return isDarkMode
        ? AppThemeData.getDarkTheme()
        : AppThemeData.getLightTheme();
  }
}
