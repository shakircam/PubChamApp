import 'package:flutter/material.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class LatestInsightsSection extends StatelessWidget {
  const LatestInsightsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleStyle = isDark ? AppTextStyles.titleLargeDark : AppTextStyles.titleLargeLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
          child: Text(
            AppLocalizations.of(context)!.latestInsights,
            style: titleStyle.copyWith(
              fontSize: AppValues.fontSize_20,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextPrimary : AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: AppValues.margin_16),
        InsightItemTile(
          icon: Icons.analytics_outlined,
          iconBg: AppColors.primary.withOpacity(AppValues.iconBackgroundOpacity),
          iconColor: AppColors.primary,
          title: AppLocalizations.of(context)!.molecularAnalysis,
          subtitle: AppLocalizations.of(context)!.realtimeBindingAffinity,
          isDark: isDark,
        ),
        const SizedBox(height: AppValues.margin_12),
        InsightItemTile(
          icon: Icons.science_outlined,
          iconBg: AppColors.primary.withOpacity(AppValues.iconBackgroundOpacity),
          iconColor: AppColors.primary,
          title: AppLocalizations.of(context)!.labIntegration,
          subtitle: AppLocalizations.of(context)!.syncWithELN,
          isDark: isDark,
        ),
      ],
    );
  }
}

class InsightItemTile extends StatelessWidget {
  const InsightItemTile({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final titleStyle = isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight;
    final subtitleStyle = isDark ? AppTextStyles.bodySmallDark : AppTextStyles.bodySmallLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to insight detail
        },
        borderRadius: BorderRadius.circular(AppValues.radius_12),
        child: Container(
          padding: const EdgeInsets.all(AppValues.padding_16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCardBackground : Colors.white,
            borderRadius: BorderRadius.circular(AppValues.radius_12),
            border: Border.all(
              color: isDark ? AppColors.darkCardBackground : AppColors.lightBottomNavBorder,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: AppValues.iconSize_48,
                height: AppValues.iconSize_48,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(AppValues.radius_12),
                ),
                child: Icon(icon, color: iconColor, size: AppValues.iconSize_24),
              ),
              const SizedBox(width: AppValues.margin_16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyle.copyWith(
                        fontSize: AppValues.fontSize_15,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: AppValues.margin_4),
                    Text(
                      subtitle,
                      style: subtitleStyle.copyWith(
                        fontSize: AppValues.fontSize_13,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
