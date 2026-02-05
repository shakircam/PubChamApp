import 'package:pubchem/app/domain/models/compound_search_result.dart';
import 'package:pubchem/app/domain/repositories/compound_search_repository.dart';

class SearchCompoundsUseCase {
  SearchCompoundsUseCase(this.repository);

  final CompoundSearchRepository repository;

  Future<List<CompoundSearchResult>> call(String query) {
    return repository.searchCompounds(query);
  }
}
