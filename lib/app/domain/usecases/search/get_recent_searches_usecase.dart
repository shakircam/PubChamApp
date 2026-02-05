import 'package:pubchem/app/domain/repositories/compound_search_repository.dart';

class GetRecentSearchesUseCase {
  GetRecentSearchesUseCase(this.repository);

  final CompoundSearchRepository repository;

  Future<List<String>> call() {
    return repository.getRecentSearches();
  }
}
