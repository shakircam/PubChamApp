import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/presentation/home/widgets/featured_molecules_section.dart';
import 'package:pubchem/app/presentation/home/widgets/home_app_bar.dart';
import 'package:pubchem/app/presentation/home/widgets/home_filter_chips.dart';
import 'package:pubchem/app/presentation/home/widgets/home_search_bar.dart';
import 'package:pubchem/app/presentation/home/widgets/latest_insights_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBar(),
              const SizedBox(height: AppValues.margin_16),
              const HomeSearchBar(),
              const SizedBox(height: AppValues.margin_16),
              const HomeFilterChips(),
              const SizedBox(height: AppValues.largeMargin),
              const FeaturedMoleculesSection(),
              const SizedBox(height: AppValues.margin_32),
              const LatestInsightsSection(),
              const SizedBox(height: AppValues.bottomNavSpacerHeight),
            ],
          ),
        ),
      ),
    );
  }
}
