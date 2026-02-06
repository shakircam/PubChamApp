import 'package:pubchem/app/domain/models/compound_details.dart';

abstract class CompoundDetailsRepository {
  Future<CompoundDetails> getCompoundDetails(int cid);
}