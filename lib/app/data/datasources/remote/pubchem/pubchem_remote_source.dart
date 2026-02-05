import 'model/pubchem_cid_response.dart';
import 'model/pubchem_property_response.dart';

abstract class PubChemRemoteSource {
  Future<PubChemPropertyResponse> getCompoundProperties(String name);
  Future<PubChemCidResponse> getCompoundCids(String name);
}
