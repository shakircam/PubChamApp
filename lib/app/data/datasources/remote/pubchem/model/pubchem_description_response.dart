class PubChemDescriptionResponse {
  final InformationList? informationList;

  const PubChemDescriptionResponse({this.informationList});

  factory PubChemDescriptionResponse.fromJson(Map<String, dynamic> json) {
    return PubChemDescriptionResponse(
      informationList: json['InformationList'] != null
          ? InformationList.fromJson(json['InformationList'])
          : null,
    );
  }
}

class InformationList {
  final List<Information> information;

  const InformationList({required this.information});

  factory InformationList.fromJson(Map<String, dynamic> json) {
    final rawList = json['Information'] as List<dynamic>? ?? const [];
    final parsed = rawList
        .whereType<Map<String, dynamic>>()
        .map(Information.fromJson)
        .toList();
    return InformationList(information: parsed);
  }
}

class Information {
  final int cid;
  final String? title;
  final String? description;
  final String? descriptionSourceName;

  const Information({
    required this.cid,
    this.title,
    this.description,
    this.descriptionSourceName,
  });

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      cid: (json['CID'] as num?)?.toInt() ?? 0,
      title: json['Title']?.toString(),
      description: json['Description']?.toString(),
      descriptionSourceName: json['DescriptionSourceName']?.toString(),
    );
  }
}