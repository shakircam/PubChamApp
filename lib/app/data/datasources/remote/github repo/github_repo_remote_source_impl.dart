import 'dart:developer';

import 'package:pubchem/app/core/base/base_remote_source.dart';
import 'package:pubchem/app/core/values/api_end_points.dart';
import 'github_repo_remote_source.dart';
import 'model/github_repository.dart';
import 'model/github_repository_params.dart';
import 'model/github_repository_response.dart';
import 'package:dio/dio.dart';

class GitHubRepositoryRemoteSourceImpl extends BaseRemoteSource
    implements GitHubRepositoryRemoteSource {
  @override
  Future<RemoteGitHubRepositoryResponse> getRepositoryList(
      GitHubRepositoryParams params) async {
    String endpoint = ApiEndPoints.repositoryListEndPoint;
    var dioCall = dioClient.get(endpoint, queryParameters: params.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseRemoteGitHubRepositoryResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  RemoteGitHubRepositoryResponse _parseRemoteGitHubRepositoryResponse(
      Response<dynamic> response) {
    return RemoteGitHubRepositoryResponse.fromJson(response.data);
  }
}
