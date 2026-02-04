import 'model/github_repository_params.dart';
import 'model/github_repository_response.dart';

abstract class GitHubRepositoryRemoteSource {
  Future<RemoteGitHubRepositoryResponse> getRepositoryList(
      GitHubRepositoryParams params);
}
