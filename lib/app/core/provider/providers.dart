import 'package:dio/dio.dart';
import 'package:pubchem/app/data/datasources/local/db/database_helper.dart';
import 'package:pubchem/app/data/datasources/local/preference/pref_manager.dart';
import 'package:pubchem/app/data/datasources/local/preference/pref_manager_impl.dart';
import 'package:pubchem/app/data/datasources/remote/github%20repo/github_repo_remote_source.dart';
import 'package:pubchem/app/data/datasources/remote/github%20repo/github_repo_remote_source_impl.dart';
import 'package:pubchem/app/data/datasources/remote/pubchem/pubchem_api_client.dart';
import 'package:pubchem/app/data/datasources/remote/pubchem/pubchem_remote_source.dart';
import 'package:pubchem/app/data/datasources/remote/pubchem/pubchem_remote_source_impl.dart';
import 'package:pubchem/app/data/repositories/compound_search_repository_impl.dart';
import 'package:pubchem/app/data/repositories/locale_repository_impl.dart';
import 'package:pubchem/app/data/repositories/theme_repository_impl.dart';
import 'package:pubchem/app/domain/repositories/compound_search_repository.dart';
import 'package:pubchem/app/domain/repositories/locale_repository.dart';
import 'package:pubchem/app/domain/repositories/theme_repository.dart';
import 'package:pubchem/app/domain/usecases/locale/get_saved_locale_usecase.dart';
import 'package:pubchem/app/domain/usecases/locale/save_locale_usecase.dart';
import 'package:pubchem/app/domain/usecases/theme/get_saved_theme_usecase.dart';
import 'package:pubchem/app/domain/usecases/theme/save_theme_usecase.dart';
import 'package:pubchem/app/domain/usecases/search/clear_recent_searches_usecase.dart';
import 'package:pubchem/app/domain/usecases/search/get_recent_searches_usecase.dart';
import 'package:pubchem/app/domain/usecases/search/save_recent_search_usecase.dart';
import 'package:pubchem/app/domain/usecases/search/search_compounds_usecase.dart';
import 'package:pubchem/app/core/values/api_end_points.dart';
import 'package:pubchem/app/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

// DATA LAYER PROVIDERS

/// Provides Dio client instance for network requests
@Riverpod(keepAlive: true)
Dio dioClient(DioClientRef ref) {
  return DioProvider.client;
}

/// Provides database helper for SQLite operations
@riverpod
DatabaseHelper databaseHelper(DatabaseHelperRef ref) {
  return DatabaseHelper();
}

/// Provides preference manager for secure storage
@Riverpod(keepAlive: true)
PrefManager prefManager(PrefManagerRef ref) {
  return PrefManagerImpl();
}

/// Provides GitHub remote data source
@Riverpod(keepAlive: true)
GitHubRepositoryRemoteSource githubRemoteSource(GithubRemoteSourceRef ref) {
  return GitHubRepositoryRemoteSourceImpl();
}

/// Provides PubChem Retrofit API client
@Riverpod(keepAlive: true)
PubChemApiClient pubChemApiClient(PubChemApiClientRef ref) {
  final dio = ref.read(dioClientProvider);
  return PubChemApiClient(dio, baseUrl: ApiEndPoints.pubChemBaseUrl);
}

/// Provides PubChem remote data source
@Riverpod(keepAlive: true)
PubChemRemoteSource pubChemRemoteSource(PubChemRemoteSourceRef ref) {
  final apiClient = ref.read(pubChemApiClientProvider);
  return PubChemRemoteSourceImpl(apiClient: apiClient);
}

// REPOSITORY PROVIDERS

/// Provides compound search repository
@Riverpod(keepAlive: true)
CompoundSearchRepository compoundSearchRepository(
    CompoundSearchRepositoryRef ref) {
  final remoteSource = ref.read(pubChemRemoteSourceProvider);
  final prefManager = ref.read(prefManagerProvider);
  return CompoundSearchRepositoryImpl(
    remoteSource: remoteSource,
    prefManager: prefManager,
  );
}

/// Provides locale repository
@Riverpod(keepAlive: true)
LocaleRepository localeRepository(LocaleRepositoryRef ref) {
  final prefManager = ref.read(prefManagerProvider);
  return LocaleRepositoryImpl(prefManager);
}

/// Provides theme repository
@Riverpod(keepAlive: true)
ThemeRepository themeRepository(ThemeRepositoryRef ref) {
  final prefManager = ref.read(prefManagerProvider);
  return ThemeRepositoryImpl(prefManager);
}

// USE CASE PROVIDERS

/// Provides get saved locale use case
@riverpod
GetSavedLocaleUseCase getSavedLocaleUseCase(GetSavedLocaleUseCaseRef ref) {
  final repository = ref.read(localeRepositoryProvider);
  return GetSavedLocaleUseCase(repository);
}

/// Provides save locale use case
@riverpod
SaveLocaleUseCase saveLocaleUseCase(SaveLocaleUseCaseRef ref) {
  final repository = ref.read(localeRepositoryProvider);
  return SaveLocaleUseCase(repository);
}

/// Provides get saved theme use case
@riverpod
GetSavedThemeUseCase getSavedThemeUseCase(GetSavedThemeUseCaseRef ref) {
  final repository = ref.read(themeRepositoryProvider);
  return GetSavedThemeUseCase(repository);
}

/// Provides save theme use case
@riverpod
SaveThemeUseCase saveThemeUseCase(SaveThemeUseCaseRef ref) {
  final repository = ref.read(themeRepositoryProvider);
  return SaveThemeUseCase(repository);
}

/// Provides search compounds use case
@riverpod
SearchCompoundsUseCase searchCompoundsUseCase(SearchCompoundsUseCaseRef ref) {
  final repository = ref.read(compoundSearchRepositoryProvider);
  return SearchCompoundsUseCase(repository);
}

/// Provides recent searches use case
@riverpod
GetRecentSearchesUseCase getRecentSearchesUseCase(
    GetRecentSearchesUseCaseRef ref) {
  final repository = ref.read(compoundSearchRepositoryProvider);
  return GetRecentSearchesUseCase(repository);
}

/// Provides save recent search use case
@riverpod
SaveRecentSearchUseCase saveRecentSearchUseCase(
    SaveRecentSearchUseCaseRef ref) {
  final repository = ref.read(compoundSearchRepositoryProvider);
  return SaveRecentSearchUseCase(repository);
}

/// Provides clear recent searches use case
@riverpod
ClearRecentSearchesUseCase clearRecentSearchesUseCase(
    ClearRecentSearchesUseCaseRef ref) {
  final repository = ref.read(compoundSearchRepositoryProvider);
  return ClearRecentSearchesUseCase(repository);
}
