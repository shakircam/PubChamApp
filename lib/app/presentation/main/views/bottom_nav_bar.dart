import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/presentation/main/models/bottom_nav_item.dart';
import 'package:pubchem/app/presentation/main/models/menu_code.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _BottomNavBarContent();
  }
}

class _BottomNavBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<BottomNavItem> navItems = _getNavItemsData();
    final int currentIndex = _getCurrentIndex(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: _getDecoration(context),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems.asMap().entries.map((entry) {
          int index = entry.key;
          BottomNavItem navItem = entry.value;
          bool isSelected = index == currentIndex;

          return Expanded(
            child: InkWell(
              onTap: () => _onTapNavItem(context, index, navItem),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon
                    Icon(
                      isSelected
                          ? navItem.activeIconData
                          : navItem.regularIconData,
                      size: 24.r,
                      color: _getItemColor(context, isSelected, isDark),
                    ),
                    SizedBox(height: 4.h),
                    // Label
                    Text(
                      navItem.navTitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: _getItemColor(context, isSelected, isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Get color based on selection state and theme
  Color _getItemColor(BuildContext context, bool isSelected, bool isDark) {
    if (isSelected) {
      return isDark
          ?  AppColors.darkBottomNavigationSelectedItem
          : AppColors.primary;
    } else {
      return isDark
          ? AppColors.lightTextSecondary
          : AppColors.darkTextSecondary;
    }
  }

  /// Determine current index based on the current route
  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/more')) return 1;
    return 0;
  }

  void _onTapNavItem(
      BuildContext context,
      int index,
      BottomNavItem navItem,
      ) {
    switch (navItem.menuCode) {
      case MenuCode.HOME:
        context.go('/home');
        break;
      case MenuCode.MORE:
        context.go('/more');
        break;
      default:
        context.go('/home');
    }
  }

  List<BottomNavItem> _getNavItemsData() {
    return [
      BottomNavItem.fromIconData(
        navTitle: "Home",
        activeIcon: Icons.home,
        regularIcon: Icons.home_outlined,
        menuCode: MenuCode.HOME,
      ),
      BottomNavItem.fromIconData(
        navTitle: "More",
        activeIcon: Icons.menu,
        regularIcon: Icons.menu_outlined,
        menuCode: MenuCode.MORE,
      ),
    ];
  }

  BoxDecoration _getDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BoxDecoration(
      color: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      border: Border(
        top: BorderSide(
          color: isDark
              ? AppColors.darkCardBackground
              : AppColors.lightBottomNavBorder,
          width: 1,
        ),
      ),
      boxShadow: isDark
          ? null
          : [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      ],
    );
  }
}