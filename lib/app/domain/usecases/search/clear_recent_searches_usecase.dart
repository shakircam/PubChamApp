import 'package:pubchem/app/domain/repositories/compound_search_repository.dart';

class ClearRecentSearchesUseCase {
  ClearRecentSearchesUseCase(this.repository);

  final CompoundSearchRepository repository;

  Future<void> call() {
    return repository.clearRecentSearches();
  }
}
