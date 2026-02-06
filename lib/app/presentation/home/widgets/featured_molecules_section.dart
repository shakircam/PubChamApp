import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/domain/models/compound.dart';
import 'package:pubchem/app/utils/compound_constants.dart';
import 'package:pubchem/l10n/app_localizations.dart';

import 'compound_card.dart';

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
              GestureDetector(
                onTap: () {
                  context.push('/featured-compounds');
                },
                child: Text(
                  AppLocalizations.of(context)!.seeAll,
                  style: titleStyle.copyWith(
                    fontSize: AppValues.fontSize_14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
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


