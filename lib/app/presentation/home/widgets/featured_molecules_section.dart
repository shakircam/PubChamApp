import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/domain/models/compound.dart';
import 'package:pubchem/app/utils/compound_constants.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class FeaturedMoleculesSection extends StatelessWidget {
  const FeaturedMoleculesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleStyle = isDark ? AppTextStyles.titleLargeDark : AppTextStyles.titleLargeLight;
    final subtitleStyle = isDark ? AppTextStyles.bodySmallDark : AppTextStyles.bodySmallLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.featuredMolecules,
                style: titleStyle.copyWith(
                  fontSize: AppValues.fontSize_20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.primary,
                ),
              ),
              const SizedBox(height: AppValues.margin_4),
              Text(
                AppLocalizations.of(context)!.curatedChemicalStructures,
                style: subtitleStyle.copyWith(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppValues.margin_16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppValues.compoundGridColumns,
              crossAxisSpacing: AppValues.margin_12,
              mainAxisSpacing: AppValues.margin_12,
              childAspectRatio: AppValues.compoundGridAspectRatio,
            ),
            itemCount: featuredCompounds.length,
            itemBuilder: (context, index) {
              final compound = featuredCompounds[index];
              return CompoundCard(compound: compound);
            },
          ),
        ),
      ],
    );
  }
}

class CompoundCard extends StatelessWidget {
  const CompoundCard({super.key, required this.compound});

  final Compound compound;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isInverted = compound.isInverted;
    final cardBgColor = isInverted
        ? (isDark ? AppColors.lightBackground : AppColors.darkBackground)
        : (isDark ? AppColors.darkCardBackground : Colors.white);
    final textColor = isInverted
        ? (isDark ? AppColors.lightTextPrimary : AppColors.darkTextPrimary)
        : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);
    final subTextColor = isInverted
        ? (isDark ? AppColors.lightTextSecondary : AppColors.darkTextSecondary)
        : AppColors.primary;
    final titleStyle = isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight;
    final subtitleStyle = isDark ? AppTextStyles.bodySmallDark : AppTextStyles.bodySmallLight;

    return GestureDetector(
      onTap: () {
        context.push('/details', extra: compound);
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(AppValues.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(AppValues.cardShadowOpacity),
              blurRadius: AppValues.margin_8,
              offset: const Offset(AppValues.margin_zero, AppValues.margin_2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(AppValues.margin_12),
                decoration: BoxDecoration(
                  color: isInverted
                      ? (isDark ? AppColors.lightBackground : AppColors.darkBackground)
                      : (isDark ? AppColors.darkSurface : AppColors.lightSurface),
                  borderRadius: BorderRadius.circular(AppValues.radius_12),
                ),
                child: Center(
                  child: Icon(
                    Icons.science_outlined,
                    size: AppValues.iconSize_40,
                    color: isInverted
                        ? (isDark ? AppColors.lightTextPrimary : AppColors.darkTextPrimary)
                        : (isDark ? Colors.white24 : Colors.black26),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppValues.padding_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    compound.name,
                    style: titleStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: AppValues.margin_4),
                  Text(
                    '${AppLocalizations.of(context)!.molecularWeightLabel}: ${compound.molecularWeight}',
                    style: subtitleStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: subTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
