class CompoundDetails {
  final int cid;
  final String name;
  final String molecularFormula;
  final double molecularWeight;
  final String iupacName;
  final String canonicalSmiles;
  final double? xLogP;
  final double? tpsa;
  final String? description;
  final String? descriptionSource;

  const CompoundDetails({
    required this.cid,
    required this.name,
    required this.molecularFormula,
    required this.molecularWeight,
    required this.iupacName,
    required this.canonicalSmiles,
    this.xLogP,
    this.tpsa,
    this.description,
    this.descriptionSource,
  });

  String get structureImageUrl =>
      'https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/$cid/record/PNG';
}