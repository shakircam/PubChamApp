import 'package:pubchem/app/domain/models/compound_details.dart';
import 'package:pubchem/app/domain/repositories/compound_details_repository.dart';

class GetCompoundDetailsUseCase {
  final CompoundDetailsRepository repository;

  GetCompoundDetailsUseCase({required this.repository});

  Future<CompoundDetails> call(int cid) async {
    return await repository.getCompoundDetails(cid);
  }
}