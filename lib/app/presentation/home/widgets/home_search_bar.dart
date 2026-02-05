import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hintStyle = isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
      child: Hero(
        tag: 'search_hero',
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.push('/search');
            },
            borderRadius: BorderRadius.circular(AppValues.radius_12),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppValues.padding_16,
                vertical: AppValues.padding_14,
              ),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCardBackground : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppValues.radius_12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: AppValues.iconSize_20,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                  const SizedBox(width: AppValues.margin_12),
                  Text(
                    AppLocalizations.of(context)!.searchForCompounds,
                    style: hintStyle.copyWith(
                      fontSize: AppValues.fontSize_15,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.mic_none,
                    size: AppValues.iconSize_20,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
