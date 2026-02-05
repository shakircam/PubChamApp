import 'package:pubchem/app/domain/models/compound_search_result.dart';

abstract class CompoundSearchRepository {
  Future<List<CompoundSearchResult>> searchCompounds(String query);
  Future<List<String>> getRecentSearches();
  Future<void> saveRecentSearch(String query);
  Future<void> clearRecentSearches();
}
