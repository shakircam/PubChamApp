import 'model/pubchem_cid_response.dart';
import 'model/pubchem_property_response.dart';
import 'model/pubchem_compound_details_response.dart';
import 'model/pubchem_description_response.dart';

abstract class PubChemRemoteSource {
  Future<PubChemPropertyResponse> getCompoundProperties(String name);
  Future<PubChemCidResponse> getCompoundCids(String name);
  Future<PubChemCompoundDetailsResponse> getCompoundDetailsByCid(int cid);
  Future<PubChemDescriptionResponse> getCompoundDescription(int cid);
}
