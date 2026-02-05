import 'package:flutter/material.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleStyle = isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.margin_16,
        vertical: AppValues.margin_8,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.science,
            color: AppColors.primary,
            size: AppValues.iconSize_28,
          ),
          const SizedBox(width: AppValues.margin_8),
          Text(
            AppLocalizations.of(context)!.pubChemIntelligence,
            style: titleStyle.copyWith(
              fontSize: AppValues.fontSize_18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
            onPressed: () {
              // TODO: Open notifications
            },
          ),
          Container(
            width: AppValues.iconSize_40,
            height: AppValues.iconSize_40,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: AppValues.iconSize_20,
              ),
              padding: EdgeInsets.zero,
              onPressed: () {
                // TODO: Open profile
              },
            ),
          ),
        ],
      ),
    );
  }
}
