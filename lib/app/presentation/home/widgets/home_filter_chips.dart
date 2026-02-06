import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/l10n/app_localizations.dart';

enum HomeFilter { trending, favorites, recent }

final homeFilterProvider = StateProvider<HomeFilter>((ref) => HomeFilter.trending);

class HomeFilterChips extends ConsumerWidget {
  const HomeFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedFilter = ref.watch(homeFilterProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
      child: Row(
        children: [
          _HomeFilterChip(
            label: AppLocalizations.of(context)!.trending,
            icon: Icons.flash_on,
            isSelected: selectedFilter == HomeFilter.trending,
            isDark: isDark,
            onSelected: () => ref.read(homeFilterProvider.notifier).state = HomeFilter.trending,
          ),
          const SizedBox(width: AppValues.margin_8),
          _HomeFilterChip(
            label: AppLocalizations.of(context)!.favorites,
            icon: Icons.star_outline,
            isSelected: selectedFilter == HomeFilter.favorites,
            isDark: isDark,
            onSelected: () => ref.read(homeFilterProvider.notifier).state = HomeFilter.favorites,
          ),
          const SizedBox(width: AppValues.margin_8),
          _HomeFilterChip(
            label: AppLocalizations.of(context)!.recent,
            icon: Icons.history,
            isSelected: selectedFilter == HomeFilter.recent,
            isDark: isDark,
            onSelected: () => ref.read(homeFilterProvider.notifier).state = HomeFilter.recent,
          ),
        ],
      ),
    );
  }
}

class _HomeFilterChip extends StatelessWidget {
  const _HomeFilterChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDark,
    required this.onSelected,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDark;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final baseLabelStyle = isDark ? AppTextStyles.labelLargeDark : AppTextStyles.labelLargeLight;
    final inactiveBorderColor = isDark
        ? AppColors.darkCardBackground.withOpacity(AppValues.borderInactiveOpacity)
        : AppColors.lightBottomNavBorder;

    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppValues.padding_16,
          vertical: AppValues.padding_10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (isDark ? AppColors.darkCardBackground : Colors.white),
          borderRadius: BorderRadius.circular(AppValues.radius_20),
          border: Border.all(
            color: isSelected ? AppColors.primary : inactiveBorderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppValues.iconSmallSize,
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            ),
            const SizedBox(width: AppValues.margin_6),
            Text(
              label,
              style: baseLabelStyle.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
