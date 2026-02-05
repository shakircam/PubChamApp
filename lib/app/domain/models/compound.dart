class Compound {
  final String name;
  final int cid;
  final String molecularWeight;
  final String formula;
  final bool isFeatured;
  final bool isTrending;
  final bool isFavorite;
  final bool isInverted; // For dark card style (like Aspirin)

  const Compound({
    required this.name,
    required this.cid,
    required this.molecularWeight,
    required this.formula,
    this.isFeatured = false,
    this.isTrending = false,
    this.isFavorite = false,
    this.isInverted = false,
  });

  // For API integration later
  factory Compound.fromJson(Map<String, dynamic> json) {
    return Compound(
      name: json['name'] ?? '',
      cid: json['cid'] ?? 0,
      molecularWeight: json['molecularWeight']?.toString() ?? '',
      formula: json['formula'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cid': cid,
      'molecularWeight': molecularWeight,
      'formula': formula,
      'isFeatured': isFeatured,
      'isTrending': isTrending,
      'isFavorite': isFavorite,
      'isInverted': isInverted,
    };
  }
}