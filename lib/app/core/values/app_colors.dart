import 'package:flutter/material.dart';

/// Core brand colors and theme-specific color definitions
/// for the PubChem Explorer app
abstract class AppColors {

  // CORE BRAND COLORS

  /// Primary brand color - Deep Cobalt Blue
  /// Used for branding, primary buttons, and active states
  static const Color primary = Color(0xFF004E92);

  /// Secondary brand color - Soft Slate Gray
  /// Used for secondary text, labels, and borders
  static const Color secondary = Color(0xFF708090);

  /// Accent color - Cyan/Clinical Blue
  /// Used for small badges, highlights, or links
  static const Color accent = Color(0xFF00B4D8);

  // LIGHT MODE THEME COLORS

  /// Light mode background - Crisp White
  /// The main canvas for all screens
  static const Color lightBackground = Color(0xFFFFFFFF);

  /// Light mode card background (base color for glassmorphism)
  /// Use with opacity 0.7 and backdrop blur for glass effect
  static const Color lightCardBackground = Color(0xFFFFFFFF);

  /// Light mode surface/tiles - Very light gray for data grid tiles
  static const Color lightSurface = Color(0xFFF8FAFC);

  /// Light mode primary text - Deep Navy
  /// High contrast for headers and compound names
  static const Color lightTextPrimary = Color(0xFF0F172A);

  /// Light mode secondary text
  /// For supporting metadata and descriptions
  static const Color lightTextSecondary = Color(0xFF64748B);

  static const Color lightBottomNavBorder = Color(0xFFE2E8F0);

  // DARK MODE THEME COLORS

  /// Dark mode background - Deep Navy
  /// A dark, clinical background
  static const Color darkBackground = Color(0xFF0B1120);

  /// Dark mode card background (base color for glassmorphism)
  /// Use with opacity 0.5 and backdrop blur for glass effect
  static const Color darkCardBackground = Color(0xFF1E293B);

  /// Dark mode surface/tiles
  /// Used for data tiles and input fields
  static const Color darkSurface = Color(0xFF1E293B);

  /// Dark mode primary text - Crisp off-white
  /// High legibility against dark backgrounds
  static const Color darkTextPrimary = Color(0xFFF8FAFC);

  /// Dark mode secondary text
  /// For muted information
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  static const Color darkBottomNavigationSelectedItem = Color(0xFF38BDF8);

  // UTILITY COLORS (Common across both themes)

  /// Success color for positive states
  static const Color success = Color(0xFF10B981);

  /// Error color for negative states and errors
  static const Color error = Color(0xFFEF4444);

  /// Warning color for cautionary states
  static const Color warning = Color(0xFFF59E0B);

  /// Info color for informational states
  static const Color info = Color(0xFF3B82F6);

  // GLASSMORPHISM HELPER COLORS

  /// Light mode card with glassmorphism effect (70% opacity)
  static Color get lightCardGlass => lightCardBackground.withOpacity(0.7);

  /// Dark mode card with glassmorphism effect (50% opacity)
  static Color get darkCardGlass => darkCardBackground.withOpacity(0.5);


  // Utility colors for settings icons
  static const Color settingsIndigo = Color(0xFF6366F1);
  static const Color settingsBlue = Color(0xFF3B82F6);
  static const Color settingsPurple = Color(0xFF8B5CF6);
  static const Color settingsPink = Color(0xFFEC4899);
  static const Color premiumOrange = Color(0xFFF59E0B);

  // CONTEXT-AWARE COLOR GETTERS

  /// Get background color based on theme brightness
  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightBackground
        : darkBackground;
  }

  /// Get card background color based on theme brightness
  static Color cardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightCardBackground
        : darkCardBackground;
  }

  /// Get card glass effect color based on theme brightness
  static Color cardGlass(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightCardGlass
        : darkCardGlass;
  }

  /// Get surface color based on theme brightness
  static Color surface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightSurface
        : darkSurface;
  }

  /// Get primary text color based on theme brightness
  static Color textPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightTextPrimary
        : darkTextPrimary;
  }

  /// Get secondary text color based on theme brightness
  static Color textSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? lightTextSecondary
        : darkTextSecondary;
  }

  // GRADIENT PRESETS (for featured compound cards)

  /// Blue to Teal gradient
  static const LinearGradient blueTealGradient = LinearGradient(
    colors: [Color(0xFF004E92), Color(0xFF00B4D8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Purple to Pink gradient
  static const LinearGradient purplePinkGradient = LinearGradient(
    colors: [Color(0xFF6B46C1), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Green to Teal gradient
  static const LinearGradient greenTealGradient = LinearGradient(
    colors: [Color(0xFF059669), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Orange to Yellow gradient
  static const LinearGradient orangeYellowGradient = LinearGradient(
    colors: [Color(0xFFF97316), Color(0xFFFBBF24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Indigo to Blue gradient
  static const LinearGradient indigoBlueGradient = LinearGradient(
    colors: [Color(0xFF4F46E5), Color(0xFF0EA5E9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Rose to Red gradient
  static const LinearGradient roseRedGradient = LinearGradient(
    colors: [Color(0xFFE11D48), Color(0xFFDC2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// List of all gradient presets for easy access
  static const List<LinearGradient> cardGradients = [
    blueTealGradient,
    purplePinkGradient,
    greenTealGradient,
    orangeYellowGradient,
    indigoBlueGradient,
    roseRedGradient,
  ];

  /// Get a gradient by index (cycles through available gradients)
  static LinearGradient getCardGradient(int index) {
    return cardGradients[index % cardGradients.length];
  }
}