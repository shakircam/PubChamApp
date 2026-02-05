class PubChemPropertyResponse {
  final PubChemPropertyTable? propertyTable;

  const PubChemPropertyResponse({this.propertyTable});

  factory PubChemPropertyResponse.fromJson(Map<String, dynamic> json) {
    return PubChemPropertyResponse(
      propertyTable: json['PropertyTable'] != null
          ? PubChemPropertyTable.fromJson(json['PropertyTable'])
          : null,
    );
  }
}

class PubChemPropertyTable {
  final List<PubChemProperty> properties;

  const PubChemPropertyTable({required this.properties});

  factory PubChemPropertyTable.fromJson(Map<String, dynamic> json) {
    final rawList = json['Properties'] as List<dynamic>? ?? const [];
    final parsed = rawList
        .whereType<Map<String, dynamic>>()
        .map(PubChemProperty.fromJson)
        .toList();
    return PubChemPropertyTable(properties: parsed);
  }
}

class PubChemProperty {
  final int cid;
  final String molecularFormula;
  final double molecularWeight;
  final String iupacName;
  final String canonicalSmiles;

  const PubChemProperty({
    required this.cid,
    required this.molecularFormula,
    required this.molecularWeight,
    required this.iupacName,
    required this.canonicalSmiles,
  });

  factory PubChemProperty.fromJson(Map<String, dynamic> json) {
    // PubChem API sometimes returns ConnectivitySMILES instead of CanonicalSMILES
    final smiles = json['CanonicalSMILES']?.toString() ??
                   json['ConnectivitySMILES']?.toString() ?? '';

    // Parse molecular weight which can be a string or number
    double molecularWeight = 0.0;
    final weightValue = json['MolecularWeight'];
    if (weightValue is num) {
      molecularWeight = weightValue.toDouble();
    } else if (weightValue is String) {
      molecularWeight = double.tryParse(weightValue) ?? 0.0;
    }

    return PubChemProperty(
      cid: (json['CID'] as num?)?.toInt() ?? 0,
      molecularFormula: json['MolecularFormula']?.toString() ?? '',
      molecularWeight: molecularWeight,
      iupacName: json['IUPACName']?.toString() ?? '',
      canonicalSmiles: smiles,
    );
  }
}
