class PubChemCompoundDetailsResponse {
  final PubChemPropertyTable? propertyTable;

  const PubChemCompoundDetailsResponse({this.propertyTable});

  factory PubChemCompoundDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PubChemCompoundDetailsResponse(
      propertyTable: json['PropertyTable'] != null
          ? PubChemPropertyTable.fromJson(json['PropertyTable'])
          : null,
    );
  }
}

class PubChemPropertyTable {
  final List<PubChemCompoundDetailsProperty> properties;

  const PubChemPropertyTable({required this.properties});

  factory PubChemPropertyTable.fromJson(Map<String, dynamic> json) {
    final rawList = json['Properties'] as List<dynamic>? ?? const [];
    final parsed = rawList
        .whereType<Map<String, dynamic>>()
        .map(PubChemCompoundDetailsProperty.fromJson)
        .toList();
    return PubChemPropertyTable(properties: parsed);
  }
}

class PubChemCompoundDetailsProperty {
  final int cid;
  final String molecularFormula;
  final double molecularWeight;
  final String iupacName;
  final String canonicalSmiles;
  final double? xLogP;
  final double? tpsa;

  const PubChemCompoundDetailsProperty({
    required this.cid,
    required this.molecularFormula,
    required this.molecularWeight,
    required this.iupacName,
    required this.canonicalSmiles,
    this.xLogP,
    this.tpsa,
  });

  factory PubChemCompoundDetailsProperty.fromJson(Map<String, dynamic> json) {
    final smiles = json['CanonicalSMILES']?.toString() ??
        json['ConnectivitySMILES']?.toString() ??
        '';

    double molecularWeight = 0.0;
    final weightValue = json['MolecularWeight'];
    if (weightValue is num) {
      molecularWeight = weightValue.toDouble();
    } else if (weightValue is String) {
      molecularWeight = double.tryParse(weightValue) ?? 0.0;
    }

    double? xLogP;
    final xLogPValue = json['XLogP'];
    if (xLogPValue is num) {
      xLogP = xLogPValue.toDouble();
    } else if (xLogPValue is String) {
      xLogP = double.tryParse(xLogPValue);
    }

    double? tpsa;
    final tpsaValue = json['TPSA'];
    if (tpsaValue is num) {
      tpsa = tpsaValue.toDouble();
    } else if (tpsaValue is String) {
      tpsa = double.tryParse(tpsaValue);
    }

    return PubChemCompoundDetailsProperty(
      cid: (json['CID'] as num?)?.toInt() ?? 0,
      molecularFormula: json['MolecularFormula']?.toString() ?? '',
      molecularWeight: molecularWeight,
      iupacName: json['IUPACName']?.toString() ?? '',
      canonicalSmiles: smiles,
      xLogP: xLogP,
      tpsa: tpsa,
    );
  }
}