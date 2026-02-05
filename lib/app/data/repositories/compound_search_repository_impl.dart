import 'dart:convert';
import 'package:pubchem/app/data/datasources/local/preference/pref_manager.dart';
import 'package:pubchem/app/data/datasources/remote/pubchem/pubchem_remote_source.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/domain/models/compound_search_result.dart';
import 'package:pubchem/app/domain/repositories/compound_search_repository.dart';
import 'package:pubchem/app/utils/constants.dart';

class CompoundSearchRepositoryImpl implements CompoundSearchRepository {
  CompoundSearchRepositoryImpl({
    required this.remoteSource,
    required this.prefManager,
  });

  final PubChemRemoteSource remoteSource;
  final PrefManager prefManager;

  @override
  Future<List<CompoundSearchResult>> searchCompounds(String query) async {
    final response = await remoteSource.getCompoundProperties(query);
    final properties = response.propertyTable?.properties ?? const [];
    return properties
        .map(
          (property) => CompoundSearchResult(
            name: property.iupacName.isNotEmpty ? property.iupacName : query,
            cid: property.cid,
            molecularFormula: property.molecularFormula,
            molecularWeight: property.molecularWeight.toString(),
            canonicalSmiles: property.canonicalSmiles.isNotEmpty
                ? property.canonicalSmiles
                : null,
          ),
        )
        .toList();
  }

  @override
  Future<List<String>> getRecentSearches() async {
    final stored = await prefManager.getString(searchHistoryKey);
    if (stored == null || stored.isEmpty) {
      return [];
    }

    try {
      final decoded = jsonDecode(stored) as List<dynamic>;
      return decoded
          .whereType<String>()
          .where((value) => value.isNotEmpty)
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> saveRecentSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return;
    }

    final existing = await getRecentSearches();
    existing.removeWhere((item) => item.toLowerCase() == trimmed.toLowerCase());
    existing.insert(0, trimmed);

    final capped = existing.take(AppValues.searchHistoryLimit).toList();
    await prefManager.setString(searchHistoryKey, jsonEncode(capped));
  }

  @override
  Future<void> clearRecentSearches() async {
    await prefManager.setString(searchHistoryKey, '');
  }
}
