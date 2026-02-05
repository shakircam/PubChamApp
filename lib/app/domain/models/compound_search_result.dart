class CompoundSearchResult {
  final String name;
  final int cid;
  final String molecularFormula;
  final String molecularWeight;
  final String? canonicalSmiles;

  const CompoundSearchResult({
    required this.name,
    required this.cid,
    required this.molecularFormula,
    required this.molecularWeight,
    this.canonicalSmiles,
  });
}
