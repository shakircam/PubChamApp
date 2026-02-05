class PubChemCidResponse {
  final PubChemIdentifierList? identifierList;

  const PubChemCidResponse({this.identifierList});

  factory PubChemCidResponse.fromJson(Map<String, dynamic> json) {
    return PubChemCidResponse(
      identifierList: json['IdentifierList'] != null
          ? PubChemIdentifierList.fromJson(json['IdentifierList'])
          : null,
    );
  }
}

class PubChemIdentifierList {
  final List<int> cids;

  const PubChemIdentifierList({required this.cids});

  factory PubChemIdentifierList.fromJson(Map<String, dynamic> json) {
    final rawList = json['CID'] as List<dynamic>? ?? const [];
    final parsed = rawList
        .map((value) => (value as num?)?.toInt() ?? 0)
        .where((value) => value > 0)
        .toList();
    return PubChemIdentifierList(cids: parsed);
  }
}
