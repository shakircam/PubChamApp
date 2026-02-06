import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/domain/models/compound.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class CompoundCard extends StatelessWidget {
  const CompoundCard({super.key, required this.compound});

  final Compound compound;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBgColor = isDark ? AppColors.darkCardBackground : Colors.white;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor = AppColors.primary;
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
            _compoundImage(isDark),
            Padding(
              padding: const EdgeInsets.all(AppValues.padding_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _compoundName(titleStyle, textColor),
                  const SizedBox(height: AppValues.margin_4),
                  _molecularWeight(context,subtitleStyle, subTextColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _compoundImage(bool isDark) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(AppValues.margin_12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(AppValues.radius_12),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppValues.radius_12),
            child: Image.network(
              'https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/${compound.cid}/record/PNG',
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.science_outlined,
                    size: AppValues.iconSize_40,
                    color: isDark ? Colors.white24 : Colors.black26,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _compoundName(TextStyle titleStyle, Color textColor) {
    return Text(
      compound.name,
      style: titleStyle.copyWith(
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  Widget _molecularWeight(BuildContext context, TextStyle subtitleStyle, Color subTextColor) {
    return Text(
      '${AppLocalizations.of(context)!.molecularWeightLabel}: ${compound.molecularWeight}',
      style: subtitleStyle.copyWith(
        fontWeight: FontWeight.w500,
        color: subTextColor,
      ),
    );
  }
}