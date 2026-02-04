import 'github_repository.dart';

class RemoteGitHubRepositoryResponse {
  List<RemoteGitHubRepository>? items;

  RemoteGitHubRepositoryResponse({
    this.items,
  });

  factory RemoteGitHubRepositoryResponse.fromJson(Map<String, dynamic> json) {
    return RemoteGitHubRepositoryResponse(
      items: List<RemoteGitHubRepository>.from(
          json['items'].map((item) => RemoteGitHubRepository.fromJson(item))),
    );
  }
}
