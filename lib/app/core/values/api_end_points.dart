abstract class ApiEndPoints {
  static const String repositoryListEndPoint = "search/repositories";
  static const String pubChemBaseUrl = "https://pubchem.ncbi.nlm.nih.gov/rest/pug/";
  static const String compoundPropertiesByName =
      "compound/name/{name}/property/"
      "MolecularFormula,MolecularWeight,IUPACName,CanonicalSMILES/JSON";
  static const String compoundCidsByName = "compound/name/{name}/cids/JSON";
  static const String compoundStructureImageByCid = "compound/cid/{cid}/record/PNG";
  static const String compoundDetailsByCid =
      "compound/cid/{cid}/property/"
      "MolecularFormula,MolecularWeight,IUPACName,CanonicalSMILES,XLogP,TPSA/JSON";
  static const String compoundDescriptionByCid = "compound/cid/{cid}/description/JSON";
}
