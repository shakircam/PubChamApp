import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_fonts.dart';
import '../values/app_text_styles.dart';

class AppThemeData {
  AppThemeData._();

  static String _getFont() {
    return AppFonts.english;
  }

  // DARK THEME

  static ThemeData getDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,

      // Primary colors
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,

      // Card and Surface colors
      cardColor: AppColors.darkCardBackground,
      canvasColor: AppColors.darkBackground,

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.darkTextPrimary,
      ),

      // Indicator and divider
      indicatorColor: AppColors.accent,
      dividerColor: AppColors.darkTextSecondary,

      // Hint color
      hintColor: AppColors.darkTextSecondary,

      // Dialog background
      dialogBackgroundColor: AppColors.darkSurface,

      // Button theme
      buttonTheme: const ButtonThemeData(
        alignedDropdown: true,
      ),

      // Text theme
      textTheme: const TextTheme(
        displaySmall: AppTextStyles.displaySmallDark,
        displayMedium: AppTextStyles.displayMediumDark,
        displayLarge: AppTextStyles.displayLargeDark,
        headlineSmall: AppTextStyles.headlineSmallDark,
        headlineMedium: AppTextStyles.headlineMediumDark,
        headlineLarge: AppTextStyles.headlineLargeDark,
        titleSmall: AppTextStyles.titleSmallDark,
        titleMedium: AppTextStyles.titleMediumDark,
        titleLarge: AppTextStyles.titleLargeDark,
        bodySmall: AppTextStyles.bodySmallDark,
        bodyMedium: AppTextStyles.bodyMediumDark,
        bodyLarge: AppTextStyles.bodyLargeDark,
        labelSmall: AppTextStyles.labelSmallDark,
        labelMedium: AppTextStyles.labelMediumDark,
        labelLarge: AppTextStyles.labelLargeDark,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.darkBackground,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.darkTextPrimary,
        ),
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.pageTitleDark.copyWith(
          fontFamily: _getFont(),
        ),
      ),

      // Font family
      fontFamily: _getFont(),

      // Color scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.darkSurface,
        background: AppColors.darkBackground,
        error: AppColors.error,
        onPrimary: AppColors.darkTextPrimary,
        onSecondary: AppColors.darkTextPrimary,
        onSurface: AppColors.darkTextPrimary,
        onBackground: AppColors.darkTextPrimary,
        onError: AppColors.darkTextPrimary,
        brightness: Brightness.dark,
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface,
        hintStyle: TextStyle(
          color: AppColors.darkTextSecondary,
          fontFamily: _getFont(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.darkTextSecondary.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.darkTextSecondary.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.accent,
            width: 2,
          ),
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.darkCardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.darkTextPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: _getFont(),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: _getFont(),
          ),
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkBackground,
          selectedItemColor: AppColors.darkBottomNavigationSelectedItem,
          unselectedItemColor: AppColors.lightTextSecondary,
          selectedIconTheme: IconThemeData(
            size: 24,
            color: AppColors.darkBottomNavigationSelectedItem,
          ),
          unselectedIconTheme: IconThemeData(
            size: 24,
            color: AppColors.lightTextSecondary,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          showSelectedLabels: true,
          showUnselectedLabels: true),
    );
  }


  // LIGHT THEME

  static ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,

      // Primary colors
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,

      // Card and Surface colors
      cardColor: AppColors.lightCardBackground,
      canvasColor: AppColors.lightBackground,

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.primary,
      ),

      // Indicator and divider
      indicatorColor: AppColors.accent,
      dividerColor: AppColors.lightTextSecondary,

      // Hint color
      hintColor: AppColors.lightTextSecondary,

      // Dialog background
      dialogBackgroundColor: AppColors.lightCardBackground,

      // Button theme
      buttonTheme: const ButtonThemeData(
        alignedDropdown: true,
      ),

      // Text theme
      textTheme: const TextTheme(
        displaySmall: AppTextStyles.displaySmallLight,
        displayMedium: AppTextStyles.displayMediumLight,
        displayLarge: AppTextStyles.displayLargeLight,
        headlineSmall: AppTextStyles.headlineSmallLight,
        headlineMedium: AppTextStyles.headlineMediumLight,
        headlineLarge: AppTextStyles.headlineLargeLight,
        titleSmall: AppTextStyles.titleSmallLight,
        titleMedium: AppTextStyles.titleMediumLight,
        titleLarge: AppTextStyles.titleLargeLight,
        bodySmall: AppTextStyles.bodySmallLight,
        bodyMedium: AppTextStyles.bodyMediumLight,
        bodyLarge: AppTextStyles.bodyLargeLight,
        labelSmall: AppTextStyles.labelSmallLight,
        labelMedium: AppTextStyles.labelMediumLight,
        labelLarge: AppTextStyles.labelLargeLight,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.lightBackground,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.pageTitleLight.copyWith(
          fontFamily: _getFont(),
        ),
      ),

      // Font family
      fontFamily: _getFont(),

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.lightSurface,
        background: AppColors.lightBackground,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: AppColors.lightTextPrimary,
        onSurface: AppColors.lightTextPrimary,
        onBackground: AppColors.lightTextPrimary,
        onError: Colors.white,
        brightness: Brightness.light,
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface,
        hintStyle: TextStyle(
          color: AppColors.lightTextSecondary,
          fontFamily: _getFont(),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.lightTextSecondary.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.lightTextSecondary.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.accent,
            width: 2,
          ),
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.lightCardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: _getFont(),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: _getFont(),
          ),
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightBackground,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        selectedIconTheme: IconThemeData(
          size: 24,
          color: AppColors.primary,
        ),
        unselectedIconTheme: IconThemeData(
          size: 24,
          color: AppColors.darkTextSecondary,
        ),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
