import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/domain/models/compound_details.dart';
import 'package:pubchem/app/presentation/details/controllers/details_controller.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  final int cid;

  const DetailsScreen({super.key, required this.cid});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final detailsState = ref.watch(detailsControllerProvider(widget.cid));

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: _DetailsAppBar(
        isDark: isDark,
        details: detailsState.details,
      ),
      body: SafeArea(
        child: _buildBody(detailsState, isDark),
      ),
    );
  }

  Widget _buildBody(DetailsState detailsState, bool isDark) {
    if (detailsState.isLoading) {
      return _buildLoadingContent(isDark);
    }

    if (detailsState.errorMessage != null) {
      return _buildErrorContent(isDark, detailsState.errorMessage!);
    }

    final details = detailsState.details;
    if (details == null) {
      return _buildEmptyContent(isDark);
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _build2DStructureSection(isDark, details.structureImageUrl),
          const SizedBox(height: AppValues.margin_24),
          _buildChemicalPropertiesSection(isDark, details),
          const SizedBox(height: AppValues.margin_24),
          if (details.description != null && details.description!.isNotEmpty)
            _buildDescriptionSection(isDark, details.description!),
          const SizedBox(height: AppValues.margin_24),
          _buildPhysicalPropertiesSection(isDark),
          const SizedBox(height: AppValues.margin_24),
          _buildActionButtons(isDark),
          const SizedBox(height: AppValues.margin_32),
        ],
      ),
    );
  }

  Widget _buildLoadingContent(bool isDark) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorContent(bool isDark, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: AppValues.margin_16),
            Text(
              AppLocalizations.of(context)!.detailsLoadingError,
              style:
                  (isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight),
            ),
            const SizedBox(height: AppValues.margin_8),
            Text(
              error,
              textAlign: TextAlign.center,
              style:
                  (isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight)
                      .copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: AppValues.margin_24),
            ElevatedButton(
              onPressed: () {
                ref.read(detailsControllerProvider(widget.cid).notifier).retry(widget.cid);
              },
              child: Text(AppLocalizations.of(context)!.searchRetry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyContent(bool isDark) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.detailsNoData,
        style: (isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight),
      ),
    );
  }

  Widget _build2DStructureSection(bool isDark, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(AppValues.radius_12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppValues.radius_12),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.broken_image_outlined, size: 64),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppValues.margin_12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.details2DStructure,
                    style: (isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight)
                        .copyWith(
                      fontSize: AppValues.fontSize_16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppValues.margin_4),
                  Text(
                    AppLocalizations.of(context)!.detailsScientificRepresentation,
                    style: (isDark ? AppTextStyles.bodySmallDark : AppTextStyles.bodySmallLight)
                        .copyWith(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.padding_8,
                      vertical: AppValues.padding_4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppValues.radius_4),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.detailsVerified,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: AppValues.fontSize_11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppValues.margin_8),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement interactive view
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.padding_16,
                        vertical: AppValues.padding_8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppValues.radius_8),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.detailsInteractive,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppValues.fontSize_13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChemicalPropertiesSection(bool isDark, details) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.detailsChemicalProperties,
                style: (isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight)
                    .copyWith(
                  fontSize: AppValues.fontSize_18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.info_outline,
                size: AppValues.iconSize_20,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ],
          ),
          const SizedBox(height: AppValues.margin_16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppValues.margin_12,
            mainAxisSpacing: AppValues.margin_12,
            childAspectRatio: 1.6,
            children: [
              _buildPropertyCard(
                isDark,
                icon: Icons.science_outlined,
                iconColor: AppColors.primary,
                value: details.molecularFormula,
                label: AppLocalizations.of(context)!.detailsMolecularFormula,
              ),
              _buildPropertyCard(
                isDark,
                icon: Icons.scale_outlined,
                iconColor: AppColors.primary,
                value: '${details.molecularWeight.toStringAsFixed(2)} g/mol',
                label: AppLocalizations.of(context)!.detailsMolecularWeight,
              ),
            ],
          ),
          const SizedBox(height: AppValues.margin_12),
          _buildPropertyCardFull(
            isDark,
            icon: Icons.text_fields,
            iconColor: AppColors.primary,
            value: details.iupacName.isNotEmpty
                ? details.iupacName
                : AppLocalizations.of(context)!.detailsNotAvailable,
            label: AppLocalizations.of(context)!.detailsIupacName,
          ),
          const SizedBox(height: AppValues.margin_12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppValues.margin_12,
            mainAxisSpacing: AppValues.margin_12,
            childAspectRatio: 1.6,
            children: [
              _buildPropertyCard(
                isDark,
                icon: Icons.water_drop_outlined,
                iconColor: AppColors.primary,
                value: details.xLogP?.toStringAsFixed(2) ?? 'N/A',
                label: AppLocalizations.of(context)!.detailsSolubility,
              ),
              _buildPropertyCard(
                isDark,
                icon: Icons.donut_small_outlined,
                iconColor: AppColors.primary,
                value: details.tpsa != null
                    ? '${details.tpsa!.toStringAsFixed(1)} Ų'
                    : 'N/A',
                label: AppLocalizations.of(context)!.detailsTpsa,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(
    bool isDark, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppValues.padding_12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(AppValues.radius_12),
        border: Border.all(
          color: isDark ? AppColors.darkCardBackground : AppColors.lightBottomNavBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: AppValues.iconSize_20),
          const Spacer(),
          Text(
            value,
            style: (isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight)
                .copyWith(
              fontSize: AppValues.fontSize_16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppValues.margin_4),
          Text(
            label,
            style: (isDark ? AppTextStyles.bodySmallDark : AppTextStyles.bodySmallLight)
                .copyWith(
              fontSize: AppValues.fontSize_10,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCardFull(
    bool isDark, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppValues.padding_12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(AppValues.radius_12),
        border: Border.all(
          color: isDark ? AppColors.darkCardBackground : AppColors.lightBottomNavBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: AppValues.iconSize_20),
          const SizedBox(height: AppValues.margin_8),
          Text(
            value,
            style: (isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight)
                .copyWith(
              fontSize: AppValues.fontSize_14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppValues.margin_4),
          Text(
            label,
            style: (isDark ? AppTextStyles.bodySmallDark : AppTextStyles.bodySmallLight)
                .copyWith(
              fontSize: AppValues.fontSize_10,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(bool isDark, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBackground : Colors.white,
          borderRadius: BorderRadius.circular(AppValues.radius_12),
          border: Border.all(
            color: isDark ? AppColors.darkCardBackground : AppColors.lightBottomNavBorder,
          ),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _isDescriptionExpanded = !_isDescriptionExpanded;
                });
              },
              borderRadius: BorderRadius.circular(AppValues.radius_12),
              child: Padding(
                padding: const EdgeInsets.all(AppValues.padding_16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: AppValues.iconSize_20,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                        const SizedBox(width: AppValues.margin_8),
                        Text(
                          AppLocalizations.of(context)!.detailsDescription,
                          style: (isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight)
                              .copyWith(
                            fontSize: AppValues.fontSize_14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      _isDescriptionExpanded ? Icons.expand_less : Icons.expand_more,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ],
                ),
              ),
            ),
            if (_isDescriptionExpanded)
              Padding(
                padding: const EdgeInsets.only(
                  left: AppValues.padding_16,
                  right: AppValues.padding_16,
                  bottom: AppValues.padding_16,
                ),
                child: Text(
                  description,
                  style: (isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight)
                      .copyWith(
                    fontSize: AppValues.fontSize_14,
                    height: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhysicalPropertiesSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
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
            Icon(
              Icons.science_outlined,
              size: AppValues.iconSize_20,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
            const SizedBox(width: AppValues.margin_8),
            Text(
              AppLocalizations.of(context)!.detailsPhysicalProperties,
              style: (isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight)
                  .copyWith(
                fontSize: AppValues.fontSize_14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement add to collection
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: AppValues.padding_14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppValues.radius_12),
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                AppLocalizations.of(context)!.detailsAddToCollection,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppValues.fontSize_15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppValues.margin_12),
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardBackground : Colors.white,
              borderRadius: BorderRadius.circular(AppValues.radius_12),
              border: Border.all(
                color: isDark ? AppColors.darkCardBackground : AppColors.lightBottomNavBorder,
              ),
            ),
            child: IconButton(
              onPressed: () {
                // TODO: Implement bookmark
              },
              icon: Icon(
                Icons.bookmark_outline,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;
  final CompoundDetails? details;

  const _DetailsAppBar({
    required this.isDark,
    this.details,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        ),
        onPressed: () => context.pop(),
      ),
      title: details != null ? _buildTitle(context) : null,
      actions: details != null ? _buildActions() : null,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          details!.name.length > 20
              ? '${details!.name.substring(0, 20)}...'
              : details!.name,
          style: (isDark
                  ? AppTextStyles.titleMediumDark
                  : AppTextStyles.titleMediumLight)
              .copyWith(
            fontSize: AppValues.fontSize_18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'CID: ${details!.cid}',
          style: (isDark
                  ? AppTextStyles.bodySmallDark
                  : AppTextStyles.bodySmallLight)
              .copyWith(
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions() {
    return [
      IconButton(
        icon: Icon(
          Icons.share_outlined,
          color: isDark
              ? AppColors.darkTextPrimary
              : AppColors.lightTextPrimary,
        ),
        onPressed: () {
          // TODO: Implement share functionality
        },
      ),
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}