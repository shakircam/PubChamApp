import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pubchem/app/core/values/app_values.dart';
import 'package:pubchem/app/data/datasources/local/preference/pref_manager.dart';
import 'package:pubchem/app/data/datasources/remote/pubchem/model/pubchem_property_response.dart';
import 'package:pubchem/app/data/datasources/remote/pubchem/pubchem_remote_source.dart';
import 'package:pubchem/app/data/repositories/compound_search_repository_impl.dart';
import 'package:pubchem/app/domain/models/compound_search_result.dart';
import 'package:pubchem/app/utils/constants.dart';

import 'compound_search_repository_impl_test.mocks.dart';

// Generate mocks with: flutter pub run build_runner build
@GenerateMocks([PubChemRemoteSource, PrefManager])
void main() {
  late CompoundSearchRepositoryImpl repository;
  late MockPubChemRemoteSource mockRemoteSource;
  late MockPrefManager mockPrefManager;

  setUp(() {
    // Create mock instances
    mockRemoteSource = MockPubChemRemoteSource();
    mockPrefManager = MockPrefManager();

    // Initialize repository with mocks
    repository = CompoundSearchRepositoryImpl(
      remoteSource: mockRemoteSource,
      prefManager: mockPrefManager,
    );
  });

  group('searchCompounds', () {
    test('should return list of CompoundSearchResult when API call succeeds', () async {
      // Arrange
      const query = 'water';
      final mockProperty = PubChemProperty(
        cid: 962,
        molecularFormula: 'H2O',
        molecularWeight: 18.015,
        iupacName: 'oxidane',
        canonicalSmiles: 'O',
      );
      final mockResponse = PubChemPropertyResponse(
        propertyTable: PubChemPropertyTable(properties: [mockProperty]),
      );

      when(mockRemoteSource.getCompoundProperties(query))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.searchCompounds(query);

      // Assert
      expect(result, isA<List<CompoundSearchResult>>());
      expect(result.length, 1);
      expect(result.first.cid, 962);
      expect(result.first.name, 'oxidane');
      expect(result.first.molecularFormula, 'H2O');
      expect(result.first.molecularWeight, '18.015');
      expect(result.first.canonicalSmiles, 'O');

      verify(mockRemoteSource.getCompoundProperties(query)).called(1);
    });

    test('should use query as name when iupacName is empty', () async {
      // Arrange
      const query = 'aspirin';
      final mockProperty = PubChemProperty(
        cid: 2244,
        molecularFormula: 'C9H8O4',
        molecularWeight: 180.16,
        iupacName: '', // Empty IUPAC name
        canonicalSmiles: 'CC(=O)OC1=CC=CC=C1C(=O)O',
      );
      final mockResponse = PubChemPropertyResponse(
        propertyTable: PubChemPropertyTable(properties: [mockProperty]),
      );

      when(mockRemoteSource.getCompoundProperties(query))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.searchCompounds(query);

      // Assert
      expect(result.first.name, query); // Should use query as name
      verify(mockRemoteSource.getCompoundProperties(query)).called(1);
    });

    test('should return null canonicalSmiles when smiles is empty', () async {
      // Arrange
      const query = 'test';
      final mockProperty = PubChemProperty(
        cid: 123,
        molecularFormula: 'C6H12O6',
        molecularWeight: 180.156,
        iupacName: 'test compound',
        canonicalSmiles: '', // Empty SMILES
      );
      final mockResponse = PubChemPropertyResponse(
        propertyTable: PubChemPropertyTable(properties: [mockProperty]),
      );

      when(mockRemoteSource.getCompoundProperties(query))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.searchCompounds(query);

      // Assert
      expect(result.first.canonicalSmiles, isNull);
      verify(mockRemoteSource.getCompoundProperties(query)).called(1);
    });

    test('should return empty list when propertyTable is null', () async {
      // Arrange
      const query = 'nonexistent';
      final mockResponse = PubChemPropertyResponse(propertyTable: null);

      when(mockRemoteSource.getCompoundProperties(query))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.searchCompounds(query);

      // Assert
      expect(result, isEmpty);
      verify(mockRemoteSource.getCompoundProperties(query)).called(1);
    });

    test('should return multiple compounds when API returns multiple results', () async {
      // Arrange
      const query = 'glucose';
      final mockProperties = [
        PubChemProperty(
          cid: 5793,
          molecularFormula: 'C6H12O6',
          molecularWeight: 180.156,
          iupacName: 'D-glucose',
          canonicalSmiles: 'C(C1C(C(C(C(O1)O)O)O)O)O',
        ),
        PubChemProperty(
          cid: 79025,
          molecularFormula: 'C6H12O6',
          molecularWeight: 180.156,
          iupacName: 'L-glucose',
          canonicalSmiles: 'C(C1C(C(C(C(O1)O)O)O)O)O',
        ),
      ];
      final mockResponse = PubChemPropertyResponse(
        propertyTable: PubChemPropertyTable(properties: mockProperties),
      );

      when(mockRemoteSource.getCompoundProperties(query))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.searchCompounds(query);

      // Assert
      expect(result.length, 2);
      expect(result[0].cid, 5793);
      expect(result[1].cid, 79025);
    });
  });

  group('getRecentSearches', () {
    test('should return list of searches when stored data is valid JSON', () async {
      // Arrange
      final storedSearches = ['water', 'glucose', 'aspirin'];
      final jsonString = jsonEncode(storedSearches);

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => jsonString);

      // Act
      final result = await repository.getRecentSearches();

      // Assert
      expect(result, storedSearches);
      verify(mockPrefManager.getString(searchHistoryKey)).called(1);
    });

    test('should return empty list when stored data is null', () async {
      // Arrange
      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => null);

      // Act
      final result = await repository.getRecentSearches();

      // Assert
      expect(result, isEmpty);
      verify(mockPrefManager.getString(searchHistoryKey)).called(1);
    });

    test('should return empty list when stored data is empty string', () async {
      // Arrange
      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => '');

      // Act
      final result = await repository.getRecentSearches();

      // Assert
      expect(result, isEmpty);
      verify(mockPrefManager.getString(searchHistoryKey)).called(1);
    });

    test('should return empty list when stored data is invalid JSON', () async {
      // Arrange
      const invalidJson = '{invalid json}';

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => invalidJson);

      // Act
      final result = await repository.getRecentSearches();

      // Assert
      expect(result, isEmpty); // Should gracefully handle error
      verify(mockPrefManager.getString(searchHistoryKey)).called(1);
    });

    test('should filter out non-string values from stored data', () async {
      // Arrange - Mixed types in JSON
      final mixedData = ['water', 123, 'glucose', null, 'aspirin'];
      final jsonString = jsonEncode(mixedData);

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => jsonString);

      // Act
      final result = await repository.getRecentSearches();

      // Assert
      expect(result, ['water', 'glucose', 'aspirin']); // Only strings
      verify(mockPrefManager.getString(searchHistoryKey)).called(1);
    });

    test('should filter out empty strings from stored data', () async {
      // Arrange
      final searches = ['water', '', 'glucose', '   ', 'aspirin'];
      final jsonString = jsonEncode(searches);

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => jsonString);

      // Act
      final result = await repository.getRecentSearches();

      // Assert
      // Note: Current implementation only filters completely empty strings, not whitespace
      expect(result, ['water', 'glucose', '   ', 'aspirin']);
    });
  });

  group('saveRecentSearch', () {
    test('should save trimmed query to recent searches', () async {
      // Arrange
      const query = '  water  ';
      const trimmedQuery = 'water';

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => null);
      when(mockPrefManager.setString(searchHistoryKey, any))
          .thenAnswer((_) async => {});

      // Act
      await repository.saveRecentSearch(query);

      // Assert
      final captured = verify(
        mockPrefManager.setString(searchHistoryKey, captureAny),
      ).captured;

      final savedData = jsonDecode(captured.first as String) as List;
      expect(savedData.first, trimmedQuery);
    });

    test('should add new search to the beginning of the list', () async {
      // Arrange
      const newQuery = 'aspirin';
      final existingSearches = ['water', 'glucose'];

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => jsonEncode(existingSearches));
      when(mockPrefManager.setString(searchHistoryKey, any))
          .thenAnswer((_) async => {});

      // Act
      await repository.saveRecentSearch(newQuery);

      // Assert
      final captured = verify(
        mockPrefManager.setString(searchHistoryKey, captureAny),
      ).captured;

      final savedData = jsonDecode(captured.first as String) as List;
      expect(savedData.first, newQuery);
      expect(savedData.length, 3);
      expect(savedData, ['aspirin', 'water', 'glucose']);
    });

    test('should remove duplicate search (case-insensitive) before adding', () async {
      // Arrange
      const newQuery = 'WATER'; // Uppercase
      final existingSearches = ['glucose', 'water', 'aspirin']; // lowercase 'water'

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => jsonEncode(existingSearches));
      when(mockPrefManager.setString(searchHistoryKey, any))
          .thenAnswer((_) async => {});

      // Act
      await repository.saveRecentSearch(newQuery);

      // Assert
      final captured = verify(
        mockPrefManager.setString(searchHistoryKey, captureAny),
      ).captured;

      final savedData = jsonDecode(captured.first as String) as List;
      expect(savedData.length, 3); // Should not increase
      expect(savedData.first, 'WATER'); // New one at start
      expect(savedData.where((e) => e.toLowerCase() == 'water').length, 1); // Only one 'water'
    });

    test('should limit searches to searchHistoryLimit', () async {
      // Arrange
      const newQuery = 'caffeine';
      final existingSearches = List.generate(
        AppValues.searchHistoryLimit,
        (i) => 'compound$i',
      ); // Already at limit (5 items)

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => jsonEncode(existingSearches));
      when(mockPrefManager.setString(searchHistoryKey, any))
          .thenAnswer((_) async => {});

      // Act
      await repository.saveRecentSearch(newQuery);

      // Assert
      final captured = verify(
        mockPrefManager.setString(searchHistoryKey, captureAny),
      ).captured;

      final savedData = jsonDecode(captured.first as String) as List;
      expect(savedData.length, AppValues.searchHistoryLimit); // Should stay at limit
      expect(savedData.first, newQuery); // New one at start
      expect(savedData.last, 'compound3'); // Last old one removed
    });

    test('should not save empty query', () async {
      // Arrange
      const emptyQuery = '';

      // Act
      await repository.saveRecentSearch(emptyQuery);

      // Assert
      verifyNever(mockPrefManager.getString(any));
      verifyNever(mockPrefManager.setString(any, any));
    });

    test('should not save whitespace-only query', () async {
      // Arrange
      const whitespaceQuery = '   ';

      // Act
      await repository.saveRecentSearch(whitespaceQuery);

      // Assert
      verifyNever(mockPrefManager.getString(any));
      verifyNever(mockPrefManager.setString(any, any));
    });

    test('should handle empty existing searches list', () async {
      // Arrange
      const query = 'water';

      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => jsonEncode([]));
      when(mockPrefManager.setString(searchHistoryKey, any))
          .thenAnswer((_) async => {});

      // Act
      await repository.saveRecentSearch(query);

      // Assert
      final captured = verify(
        mockPrefManager.setString(searchHistoryKey, captureAny),
      ).captured;

      final savedData = jsonDecode(captured.first as String) as List;
      expect(savedData.length, 1);
      expect(savedData.first, query);
    });
  });

  group('clearRecentSearches', () {
    test('should clear all recent searches by setting empty string', () async {
      // Arrange
      when(mockPrefManager.setString(searchHistoryKey, ''))
          .thenAnswer((_) async => {});

      // Act
      await repository.clearRecentSearches();

      // Assert
      verify(mockPrefManager.setString(searchHistoryKey, '')).called(1);
    });

    test('should call setString with correct parameters', () async {
      // Arrange
      when(mockPrefManager.setString(any, any))
          .thenAnswer((_) async => {});

      // Act
      await repository.clearRecentSearches();

      // Assert
      verify(mockPrefManager.setString(searchHistoryKey, '')).called(1);
      verifyNoMoreInteractions(mockPrefManager);
    });
  });

  group('integration scenarios', () {
    test('should handle complete search workflow: search -> save -> retrieve', () async {
      // Arrange - Search
      const query = 'water';
      final mockProperty = PubChemProperty(
        cid: 962,
        molecularFormula: 'H2O',
        molecularWeight: 18.015,
        iupacName: 'oxidane',
        canonicalSmiles: 'O',
      );
      final mockResponse = PubChemPropertyResponse(
        propertyTable: PubChemPropertyTable(properties: [mockProperty]),
      );

      when(mockRemoteSource.getCompoundProperties(query))
          .thenAnswer((_) async => mockResponse);
      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => null);
      when(mockPrefManager.setString(searchHistoryKey, any))
          .thenAnswer((_) async => {});

      // Act - Search
      final searchResult = await repository.searchCompounds(query);

      // Assert - Search results
      expect(searchResult, isNotEmpty);
      expect(searchResult.first.name, 'oxidane');

      // Act - Save search
      await repository.saveRecentSearch(query);

      // Simulate getting the saved data
      final savedJson = verify(
        mockPrefManager.setString(searchHistoryKey, captureAny),
      ).captured.first as String;

      // Setup for retrieval
      when(mockPrefManager.getString(searchHistoryKey))
          .thenAnswer((_) async => savedJson);

      // Act - Retrieve history
      final history = await repository.getRecentSearches();

      // Assert - History contains the search
      expect(history, contains(query));
    });
  });
}