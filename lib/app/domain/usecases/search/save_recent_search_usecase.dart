import 'package:pubchem/app/domain/repositories/compound_search_repository.dart';

class SaveRecentSearchUseCase {
  SaveRecentSearchUseCase(this.repository);

  final CompoundSearchRepository repository;

  Future<void> call(String query) {
    return repository.saveRecentSearch(query);
  }
}
