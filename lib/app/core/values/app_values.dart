import 'package:flutter/material.dart';

abstract class AppValues {
  static const double appBarIconSize = 24;
  static const double circularImageSize_30 = 30;
  static const double defaultScreenHeight = 640;
  static const double defaultScreenWidth = 360;
  static const double maxButtonHeight = 38;
  static const double maxButtonWidth = 496;
  static const double fontSize_10 = 10;
  static const double fontSize_11 = 11;
  static const double fontSize_12 = 12;
  static const double fontSize_13 = 13;
  static const double fontSize_14 = 14;
  static const double fontSize_15 = 15;
  static const double fontSize_16 = 16;
  static const double fontSize_18 = 18;
  static const double fontSize_19 = 19;
  static const double fontSize_20 = 20;
  static const double fontSize_21 = 21;
  static const double fontSize_24 = 24;
  static const double fontSize_25 = 25;
  static const double fontSize_26 = 26;
  static const double fontSize_27 = 27;
  static const double fontSize_28 = 28;
  static const double fontSize_30 = 30;
  static const double fontSize_31 = 31;
  static const double fontSize_32 = 32;
  static const double fontSize_40 = 40;
  static const double fontSize_48 = 48;
  static const double halfPadding = 8;
  static const double iconDefaultSize = 24;
  static const double iconExtraLargerSize = 96;
  static const double iconLargeSize = 36;
  static const double iconSizeLauncher = 200;
  static const double iconSize_5 = 5;
  static const double iconSize_10 = 10;
  static const double iconSize_14 = 14;
  static const double iconSize_18 = 18;
  static const double iconSize_20 = 20;
  static const double iconSize_22 = 22;
  static const double iconSize_24 = 24;
  static const double iconSize_28 = 28;
  static const double iconSize_30 = 30;
  static const double iconSize_32 = 32;
  static const double iconSize_36 = 36;
  static const double iconSize_40 = 40;
  static const double iconSize_48 = 48;
  static const double iconSize_50 = 50;
  static const double iconSize_60 = 60;
  static const double iconSize_75 = 75;
  static const double iconSmallerSize = 12;
  static const double iconSmallSize = 16;
  static const double inactiveIndicatorSize = 10;
  static const double indicatorDefaultSize = 8;
  static const double indicatorShadowBlurRadius = 1;
  static const double indicatorShadowSpreadRadius = 0;
  static const double initialLat = 23.732576;
  static const double initialLon = 90.384973;
  static const double inputFieldBorderWidth = 2;
  static const double inputFieldCornerRadius = 8;
  static const double InputFieldHeight = 52;
  static const double largeElevation = 24;
  static const double largeMargin = 24;
  static const double largePadding = 24;
  static const double radius_24 = 24;
  static const double listBottomEmptySpace = 200;
  static const double margin = 16;
  static const double marginBelowVerticalLine = 64;
  static const double margin_10 = 10;
  static const double margin_12 = 12;
  static const double margin_16 = 16;
  static const double margin_18 = 18;
  static const double margin_26 = 26;
  static const double margin_2 = 2;
  static const double margin_20 = 20;
  static const double margin_24 = 24;
  static const double margin_30 = 30;
  static const double margin_32 = 32;
  static const double margin_3 = 4;
  static const double margin_4 = 4;
  static const double margin_40 = 40;
  static const double margin_6 = 6;
  static const double margin_8 = 8;
  static const double margin_zero = 0;
  static const double padding = 15;
  static const double padding_10 = 10;
  static const double padding_12 = 12;
  static const double padding_14 = 14;
  static const double padding_15 = 15;
  static const double padding_16 = 16;
  static const double padding_2 = 2;
  static const double padding_20 = 20;
  static const double padding_24 = 24;
  static const double padding_30 = 30;
  static const double padding_3 = 3;
  static const double padding_4 = 4;
  static const double padding_5 = 5;
  static const double padding_8 = 8;
  static const double padding_zero = 0;
  static const double radius = 16;
  static const double radius_12 = 12;
  static const double radius_4 = 4;
  static const double radius_5 = 5;
  static const double radius_8 = 8;
  static const double radius_20 = 20;
  static const double smallRadius = 8;
  static const double smallPadding = 10;
  static const double extraLargeMargin = 36;
  static const int searchDebounceMs = 400;
  static const int searchHistoryLimit = 5;
  static const double cardShadowOpacity = 0.05;
  static const double iconBackgroundOpacity = 0.15;
  static const double borderInactiveOpacity = 0.3;
  static const double compoundGridAspectRatio = 0.85;
  static const double bottomNavSpacerHeight = 100;

  // Responsive breakpoints
  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1200;

  // Deprecated: Use getResponsiveGridColumns() instead
  @Deprecated('Use getResponsiveGridColumns(context) for responsive layouts')
  static const int compoundGridColumns = 2;

  static const Widget sizedBoxShrink = SizedBox.shrink();
  static const double tabBarHeight = 32.0;
  static const double singleTitleCartItemHeight = 60;

  /// Returns the number of grid columns based on screen width
  /// - Phone (< 600): 2 columns
  /// - Tablet (600-1199): 3 columns
  /// - Desktop (>= 1200): 4 columns
  static int getResponsiveGridColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= desktopBreakpoint) {
      return 4; // Desktop
    } else if (width >= tabletBreakpoint) {
      return 3; // Tablet
    } else {
      return 2; // Phone
    }
  }

  /// Returns responsive cross axis spacing for grid layouts
  static double getResponsiveGridSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= desktopBreakpoint) {
      return margin_16; // Desktop - more spacing
    } else if (width >= tabletBreakpoint) {
      return margin_12; // Tablet - medium spacing
    } else {
      return margin_12; // Phone - compact spacing
    }
  }

  /// Returns responsive height based on percentage of screen height
  /// [percentage] - Percentage of screen height (0.0 to 1.0)
  /// [minHeight] - Minimum height constraint
  /// [maxHeight] - Maximum height constraint
  static double getResponsiveHeight(
    BuildContext context, {
    required double percentage,
    double? minHeight,
    double? maxHeight,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    double height = screenHeight * percentage;

    if (minHeight != null && height < minHeight) {
      height = minHeight;
    }
    if (maxHeight != null && height > maxHeight) {
      height = maxHeight;
    }

    return height;
  }

  /// Returns responsive width based on percentage of screen width
  /// [percentage] - Percentage of screen width (0.0 to 1.0)
  /// [minWidth] - Minimum width constraint
  /// [maxWidth] - Maximum width constraint
  static double getResponsiveWidth(
    BuildContext context, {
    required double percentage,
    double? minWidth,
    double? maxWidth,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    double width = screenWidth * percentage;

    if (minWidth != null && width < minWidth) {
      width = minWidth;
    }
    if (maxWidth != null && width > maxWidth) {
      width = maxWidth;
    }

    return width;
  }
}
