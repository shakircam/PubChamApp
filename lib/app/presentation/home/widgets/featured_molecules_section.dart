import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/utils/compound_constants.dart';
import 'package:pubchem/app/utils/context_ext.dart';
import 'package:pubchem/l10n/app_localizations.dart' show AppLocalizations;

import 'compound_card.dart';

class FeaturedMoleculesSection extends StatelessWidget {
  const FeaturedMoleculesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
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
              _seeAllText(context,titleStyle),
            ],
          ),
        ),
        const SizedBox(height: AppValues.margin_16),
        _compoundItemsList(context),
      ],
    );
  }

  Widget _seeAllText(BuildContext context, TextStyle titleStyle) {
    return GestureDetector(
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
    );
  }

  Widget _compoundItemsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppValues.getResponsiveGridColumns(context),
          crossAxisSpacing: AppValues.getResponsiveGridSpacing(context),
          mainAxisSpacing: AppValues.getResponsiveGridSpacing(context),
          childAspectRatio: AppValues.compoundGridAspectRatio,
        ),
        itemCount: featuredCompounds.length,
        itemBuilder: (context, index) {
          final compound = featuredCompounds[index];
          return CompoundCard(compound: compound);
        },
      ),
    );
  }
}
