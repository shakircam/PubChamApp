import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/presentation/home/controllers/featured_compounds_controller.dart';
import 'package:pubchem/app/presentation/home/widgets/compound_card.dart';
import 'package:pubchem/app/presentation/home/widgets/featured_molecules_section.dart';
import 'package:pubchem/app/utils/context_ext.dart';
import 'package:pubchem/l10n/app_localizations.dart';

class FeaturedCompoundsPage extends ConsumerStatefulWidget {
  const FeaturedCompoundsPage({super.key});

  @override
  ConsumerState<FeaturedCompoundsPage> createState() => _FeaturedCompoundsPageState();
}

class _FeaturedCompoundsPageState extends ConsumerState<FeaturedCompoundsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = ref.read(featuredCompoundsControllerProvider);
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !state.isLoading &&
        state.hasMore) {
      ref.read(featuredCompoundsControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final titleStyle =
        isDark ? AppTextStyles.titleLargeDark : AppTextStyles.titleLargeLight;
    final state = ref.watch(featuredCompoundsControllerProvider);

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor:
            isDark ? AppColors.darkBackground : AppColors.lightBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.darkTextPrimary : AppColors.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.featuredMolecules,
          style: titleStyle.copyWith(
            fontSize: AppValues.fontSize_20,
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextPrimary : AppColors.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(AppValues.margin_16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppValues.compoundGridColumns,
                  crossAxisSpacing: AppValues.margin_12,
                  mainAxisSpacing: AppValues.margin_12,
                  childAspectRatio: AppValues.compoundGridAspectRatio,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CompoundCard(compound: state.displayedCompounds[index]);
                  },
                  childCount: state.displayedCompounds.length,
                ),
              ),
            ),
            if (state.isLoading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppValues.margin_16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            if (!state.hasMore && state.displayedCompounds.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppValues.margin_16),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.noMoreItems,
                      style: (isDark
                              ? AppTextStyles.bodySmallDark
                              : AppTextStyles.bodySmallLight)
                          .copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}