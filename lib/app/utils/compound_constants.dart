import 'package:pubchem/app/domain/models/compound.dart';

// Predefined list of compounds with CID and molecular weights from PubChem
const List<Compound> allCompounds = [
  // Featured compounds (first 4 shown in grid)
  Compound(
    name: 'Caffeine',
    cid: 2519,
    molecularWeight: '194.19',
    formula: 'C8H10N4O2',
    isFeatured: true,
    isTrending: true,
  ),
  Compound(
    name: 'Aspirin',
    cid: 2244,
    molecularWeight: '180.16',
    formula: 'C9H8O4',
    isFeatured: true,
    isTrending: true,
  ),
  Compound(
    name: 'Dopamine',
    cid: 681,
    molecularWeight: '153.18',
    formula: 'C8H11NO2',
    isFeatured: true,
    isTrending: true,
  ),
  Compound(
    name: 'Glucose',
    cid: 5793,
    molecularWeight: '180.16',
    formula: 'C6H12O6',
    isFeatured: true,
    isTrending: true,
  ),

  // Additional compounds
  Compound(
    name: 'Ibuprofen',
    cid: 3672,
    molecularWeight: '206.28',
    formula: 'C13H18O2',
    isTrending: true,
  ),
  Compound(
    name: 'Ethanol',
    cid: 702,
    molecularWeight: '46.07',
    formula: 'C2H6O',
  ),
  Compound(
    name: 'Paracetamol',
    cid: 1983,
    molecularWeight: '151.16',
    formula: 'C8H9NO2',
    isTrending: true,
  ),
  Compound(
    name: 'Vitamin C',
    cid: 54670067,
    molecularWeight: '176.12',
    formula: 'C6H8O6',
  ),
  Compound(
    name: 'Cholesterol',
    cid: 5997,
    molecularWeight: '386.65',
    formula: 'C27H46O',
  ),
  Compound(
    name: 'Benzene',
    cid: 241,
    molecularWeight: '78.11',
    formula: 'C6H6',
  ),
  Compound(
    name: 'Acetaminophen',
    cid: 1983,
    molecularWeight: '151.16',
    formula: 'C8H9NO2',
  ),
  Compound(
    name: 'Penicillin',
    cid: 5904,
    molecularWeight: '334.39',
    formula: 'C16H18N2O4S',
  ),
  Compound(
    name: 'Morphine',
    cid: 5288826,
    molecularWeight: '285.34',
    formula: 'C17H19NO3',
  ),
  Compound(
    name: 'Insulin',
    cid: 16129672,
    molecularWeight: '5808',
    formula: 'C257H383N65O77S6',
  ),
  Compound(
    name: 'Serotonin',
    cid: 5202,
    molecularWeight: '176.22',
    formula: 'C10H12N2O',
  ),
  Compound(
    name: 'Melatonin',
    cid: 896,
    molecularWeight: '232.28',
    formula: 'C13H16N2O2',
  ),
  Compound(
    name: 'Histamine',
    cid: 774,
    molecularWeight: '111.15',
    formula: 'C5H9N3',
  ),
  Compound(
    name: 'Adrenaline',
    cid: 5816,
    molecularWeight: '183.20',
    formula: 'C9H13NO3',
  ),
  Compound(
    name: 'Cortisol',
    cid: 5754,
    molecularWeight: '362.46',
    formula: 'C21H30O5',
  ),
  Compound(
    name: 'Testosterone',
    cid: 6013,
    molecularWeight: '288.42',
    formula: 'C19H28O2',
  ),
  Compound(
    name: 'Estrogen',
    cid: 5757,
    molecularWeight: '272.38',
    formula: 'C18H24O2',
  ),
  Compound(
    name: 'Nicotine',
    cid: 89594,
    molecularWeight: '162.23',
    formula: 'C10H14N2',
  ),
  Compound(
    name: 'Sodium Chloride',
    cid: 5234,
    molecularWeight: '58.44',
    formula: 'NaCl',
  ),
  Compound(
    name: 'Water',
    cid: 962,
    molecularWeight: '18.015',
    formula: 'H2O',
  ),
  Compound(
    name: 'Fructose',
    cid: 5984,
    molecularWeight: '180.16',
    formula: 'C6H12O6',
  ),
];

// Filter helpers
List<Compound> get featuredCompounds =>
    allCompounds.where((c) => c.isFeatured).toList();

List<Compound> get trendingCompounds =>
    allCompounds.where((c) => c.isTrending).toList();

List<Compound> getFavoriteCompounds(List<int> favoriteCids) =>
    allCompounds.where((c) => favoriteCids.contains(c.cid)).toList();