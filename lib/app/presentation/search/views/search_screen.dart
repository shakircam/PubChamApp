import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pubchem/app/core/values/api_end_points.dart';
import 'package:pubchem/app/core/values/app_colors.dart';
import 'package:pubchem/app/core/values/app_text_styles.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/domain/models/compound_search_result.dart';
import 'package:pubchem/app/presentation/search/controllers/search_controller.dart'
    as search;
import 'package:pubchem/l10n/app_localizations.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus search field when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final searchState = ref.watch(search.searchControllerProvider);
    final searchNotifier = ref.read(search.searchControllerProvider.notifier);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(isDark),
            Expanded(
              child: _buildBody(searchState, searchNotifier, isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    final inputStyle = isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.margin_16,
        vertical: AppValues.margin_8,
      ),
      child: Row(
        children: [
          _backButton(isDark),
          Expanded(
            child: Hero(
              tag: 'search_hero',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.padding_16,
                    vertical: AppValues.padding_14,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBackground : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(AppValues.radius_12),
                  ),
                  child: Row(
                    children: [
                      _searchIcon(isDark),
                      const SizedBox(width: AppValues.margin_12),
                      _searchTextField(inputStyle, isDark),
                      if (_searchController.text.isNotEmpty)
                        _clearButton(isDark),
                      _recorderIcon(isDark),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton(bool isDark) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      ),
      onPressed: () => context.pop(),
    );
  }

  Widget _searchIcon(bool isDark) {
    return Icon(
      Icons.search,
      size: AppValues.iconSize_20,
      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
    );
  }

  Widget _searchTextField(TextStyle inputStyle, bool isDark) {
    return Expanded(
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        style: inputStyle.copyWith(
          fontSize: AppValues.fontSize_15,
          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
        ),
        decoration: _textFieldDecoration(inputStyle),
        onChanged: (value) {
          ref.read(search.searchControllerProvider.notifier).onQueryChanged(value);
          setState(() {});
        },
      ),
    );
  }

  Widget _recorderIcon(bool isDark) {
    return Icon(
      Icons.mic_none,
      size: AppValues.iconSize_20,
      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
    );
  }

  Widget _clearButton(bool isDark) {
    return IconButton(
      icon: Icon(
        Icons.clear,
        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        size: AppValues.iconSize_20,
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () {
        _searchController.clear();
        ref.read(search.searchControllerProvider.notifier).onQueryChanged('');
        setState(() {});
      },
    );
  }

  InputDecoration? _textFieldDecoration(TextStyle inputStyle) {
    return InputDecoration(
      hintText: AppLocalizations.of(context)!.searchForCompounds,
      hintStyle: inputStyle.copyWith(
        fontSize: AppValues.fontSize_15,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary,
      ),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      isDense: true,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildBody(
    search.SearchState searchState,
    search.SearchController searchNotifier,
    bool isDark,
  ) {
    if (searchState.query.trim().isEmpty) {
      return _buildRecentSearches(searchState, searchNotifier, isDark);
    }
    if (searchState.isLoading) {
      return _buildLoadingState(isDark);
    }
    if (searchState.errorMessage != null) {
      return _buildErrorState(searchNotifier, isDark);
    }
    if (searchState.results.isEmpty && searchState.hasSearched) {
      return _buildEmptyState(isDark);
    }
    if (searchState.results.isEmpty) {
      return const SizedBox.shrink();
    }
    return _buildResultsList(searchState.results, isDark);
  }

  Widget _buildRecentSearches(
    search.SearchState searchState,
    search.SearchController searchNotifier,
    bool isDark,
  ) {
    final titleStyle = isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight;
    final bodyStyle = isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight;

    if (searchState.recentSearches.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.searchNoRecent,
          style: bodyStyle.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppValues.margin_8),
      itemCount: searchState.recentSearches.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.searchRecentTitle,
                  style: titleStyle.copyWith(
                    fontSize: AppValues.fontSize_16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => searchNotifier.clearRecentSearches(),
                  child: Text(
                    AppLocalizations.of(context)!.searchClearHistory,
                    style: bodyStyle.copyWith(
                      fontSize: AppValues.fontSize_14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final query = searchState.recentSearches[index - 1];
        return ListTile(
          onTap: () => _applyRecentSearch(query, searchNotifier),
          leading: Icon(
            Icons.history,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
          title: Text(
            query,
            style: bodyStyle.copyWith(
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState(bool isDark) {
    final bodyStyle = isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppValues.margin_12),
          Text(
            AppLocalizations.of(context)!.searchingLabel,
            style: bodyStyle.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    final titleStyle = isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight;
    final bodyStyle = isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: AppValues.iconLargeSize,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
          const SizedBox(height: AppValues.margin_12),
          Text(
            AppLocalizations.of(context)!.searchEmptyTitle,
            style: titleStyle.copyWith(
              fontSize: AppValues.fontSize_16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppValues.margin_4),
          Text(
            AppLocalizations.of(context)!.searchEmptySubtitle,
            style: bodyStyle.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(search.SearchController searchNotifier, bool isDark) {
    final titleStyle = isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight;
    final bodyStyle = isDark ? AppTextStyles.bodyMediumDark : AppTextStyles.bodyMediumLight;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.margin_16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppValues.iconLargeSize,
              color: AppColors.error,
            ),
            const SizedBox(height: AppValues.margin_12),
            Text(
              AppLocalizations.of(context)!.searchErrorTitle,
              style: titleStyle.copyWith(
                fontSize: AppValues.fontSize_16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppValues.margin_4),
            Text(
              AppLocalizations.of(context)!.searchErrorSubtitle,
              textAlign: TextAlign.center,
              style: bodyStyle.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: AppValues.margin_12),
            ElevatedButton(
              onPressed: () => searchNotifier.retry(),
              child: Text(AppLocalizations.of(context)!.searchRetry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(List<CompoundSearchResult> results, bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.margin_16,
        vertical: AppValues.margin_8,
      ),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppValues.margin_12),
      itemBuilder: (context, index) {
        final result = results[index];
        return _buildResultCard(result, isDark);
      },
    );
  }

  Widget _buildResultCard(CompoundSearchResult result, bool isDark) {
    final titleStyle = isDark ? AppTextStyles.titleMediumDark : AppTextStyles.titleMediumLight;
    final bodyStyle = isDark ? AppTextStyles.bodySmallDark : AppTextStyles.bodySmallLight;
    final imageUrl = _structureImageUrl(result.cid);

    return InkWell(
      onTap: () => context.push('/details', extra: result.cid),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.name,
                    style: titleStyle.copyWith(
                      fontSize: AppValues.fontSize_16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: AppValues.margin_4),
                  Text(
                    '${AppLocalizations.of(context)!.compoundIdLabel}: ${result.cid}',
                    style: bodyStyle.copyWith(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  if (result.molecularFormula.isNotEmpty) ...[
                    const SizedBox(height: AppValues.margin_4),
                    Text(
                      result.molecularFormula,
                      style: bodyStyle.copyWith(
                        color:
                            isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppValues.margin_12),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppValues.radius_8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: AppValues.iconSize_60,
                height: AppValues.iconSize_60,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: AppValues.iconSize_20,
                    height: AppValues.iconSize_20,
                    child: CircularProgressIndicator(strokeWidth: AppValues.margin_2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _structureImageUrl(int cid) {
    final path =
        ApiEndPoints.compoundStructureImageByCid.replaceFirst('{cid}', '$cid');
    return '${ApiEndPoints.pubChemBaseUrl}$path';
  }

  void _applyRecentSearch(String query, search.SearchController searchNotifier) {
    _searchController.text = query;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
    searchNotifier.onRecentSearchSelected(query);
  }
}
