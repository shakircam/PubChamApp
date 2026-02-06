import 'package:pubchem/app/data/datasources/remote/pubchem/pubchem_remote_source.dart';
import 'package:pubchem/app/domain/models/compound_details.dart';
import 'package:pubchem/app/domain/repositories/compound_details_repository.dart';

class CompoundDetailsRepositoryImpl implements CompoundDetailsRepository {
  final PubChemRemoteSource remoteSource;

  CompoundDetailsRepositoryImpl({required this.remoteSource});

  @override
  Future<CompoundDetails> getCompoundDetails(int cid) async {
    // Fetch compound properties
    final detailsResponse = await remoteSource.getCompoundDetailsByCid(cid);
    final property = detailsResponse.propertyTable?.properties.firstOrNull;

    if (property == null) {
      throw Exception('No compound data found for CID: $cid');
    }

    // Fetch description (may fail, so we handle it gracefully)
    String? description;
    String? descriptionSource;

    try {
      final descResponse = await remoteSource.getCompoundDescription(cid);
      final info = descResponse.informationList?.information.firstOrNull;
      description = info?.description;
      descriptionSource = info?.descriptionSourceName;
    } catch (e) {
      // Description is optional, continue without it
      description = null;
      descriptionSource = null;
    }

    return CompoundDetails(
      cid: property.cid,
      name: property.iupacName.isNotEmpty ? property.iupacName : 'Compound $cid',
      molecularFormula: property.molecularFormula,
      molecularWeight: property.molecularWeight,
      iupacName: property.iupacName,
      canonicalSmiles: property.canonicalSmiles,
      xLogP: property.xLogP,
      tpsa: property.tpsa,
      description: description,
      descriptionSource: descriptionSource,
    );
  }
}