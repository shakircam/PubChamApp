import 'package:dio/dio.dart';
import 'package:pubchem/app/data/datasources/local/db/database_helper.dart';
import 'package:pubchem/app/data/datasources/local/preference/pref_manager.dart';
import 'package:pubchem/app/data/datasources/local/preference/pref_manager_impl.dart';
import 'package:pubchem/app/data/datasources/remote/github%20repo/github_repo_remote_source.dart';
import 'package:pubchem/app/data/datasources/remote/github%20repo/github_repo_remote_source_impl.dart';
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

