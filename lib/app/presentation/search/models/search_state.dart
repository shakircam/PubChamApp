import 'package:pubchem/app/domain/models/compound_search_result.dart';

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