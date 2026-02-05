import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/core/provider/providers.dart';
import 'package:pubchem/app/domain/models/compound_search_result.dart';

part 'search_controller.g.dart';

class SearchState {
  final String query;
  final bool isLoading;
  final String? errorMessage;
  final List<CompoundSearchResult> results;
  final List<String> recentSearches;
  final bool hasSearched;

  const SearchState({
    this.query = '',
    this.isLoading = false,
    this.errorMessage,
    this.results = const [],
    this.recentSearches = const [],
    this.hasSearched = false,
  });

  SearchState copyWith({
    String? query,
    bool? isLoading,
    String? errorMessage,
    List<CompoundSearchResult>? results,
    List<String>? recentSearches,
    bool? hasSearched,
  }) {
    return SearchState(
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      results: results ?? this.results,
      recentSearches: recentSearches ?? this.recentSearches,
      hasSearched: hasSearched ?? this.hasSearched,
    );
  }
}

@riverpod
class SearchController extends _$SearchController {
  Timer? _debounce;
  bool _initialized = false;

  @override
  SearchState build() {
    if (!_initialized) {
      _initialized = true;
      Future.microtask(_loadRecentSearches);
    }
    ref.onDispose(() {
      _debounce?.cancel();
    });
    return const SearchState();
  }

  Future<void> _loadRecentSearches() async {
    final recent = await ref.read(getRecentSearchesUseCaseProvider).call();
    state = state.copyWith(recentSearches: recent);
  }

  void onQueryChanged(String query) {
    state = state.copyWith(query: query, errorMessage: null);
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _debounce?.cancel();
      state = state.copyWith(
        results: [],
        isLoading: false,
        hasSearched: false,
      );
      return;
    }

    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: AppValues.searchDebounceMs),
      () {
      _search(trimmed);
      },
    );
  }

  Future<void> retry() async {
    final trimmed = state.query.trim();
    if (trimmed.isEmpty) {
      return;
    }
    await _search(trimmed);
  }

  Future<void> _search(String query) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      hasSearched: true,
    );

    try {
      final results =
          await ref.read(searchCompoundsUseCaseProvider).call(query);
      state = state.copyWith(
        isLoading: false,
        results: results,
        errorMessage: null,
      );
      if (results.isNotEmpty) {
        await ref.read(saveRecentSearchUseCaseProvider).call(query);
        await _loadRecentSearches();
      }
    } catch (error, stackTrace) {
      // Log the error for debugging
      print('Search error: $error');
      print('Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        results: [],
        errorMessage: error.toString(),
      );
    }
  }

  void onRecentSearchSelected(String query) {
    onQueryChanged(query);
  }

  Future<void> clearRecentSearches() async {
    await ref.read(clearRecentSearchesUseCaseProvider).call();
    state = state.copyWith(recentSearches: []);
  }
}
