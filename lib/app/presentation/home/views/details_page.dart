import 'package:flutter/material.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/domain/models/compound.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class DetailsPage extends StatelessWidget {
  final Compound? compound;
  final int? cid;

  const DetailsPage({
    super.key,
    this.compound,
    this.cid,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleStyle = isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight;
    final bodyStyle = isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          compound?.name ?? AppLocalizations.of(context)!.compoundDetailsTitle,
          style: titleStyle.copyWith(
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        elevation: AppValues.margin_zero,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.detailsScreenComingSoon,
              style: titleStyle.copyWith(
                fontSize: AppValues.fontSize_18,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
            const SizedBox(height: AppValues.margin_16),
            if (compound != null) ...[
              Text(
                compound!.name,
                style: bodyStyle.copyWith(
                  fontSize: AppValues.fontSize_16,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              Text(
                '${AppLocalizations.of(context)!.compoundIdLabel}: ${compound!.cid}',
                style: bodyStyle.copyWith(
                  fontSize: AppValues.fontSize_14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              Text(
                '${AppLocalizations.of(context)!.molecularWeightLabel}: ${compound!.molecularWeight}',
                style: bodyStyle.copyWith(
                  fontSize: AppValues.fontSize_14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ] else if (cid != null) ...[
              Text(
                '${AppLocalizations.of(context)!.compoundIdLabel}: $cid',
                style: bodyStyle.copyWith(
                  fontSize: AppValues.fontSize_14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
