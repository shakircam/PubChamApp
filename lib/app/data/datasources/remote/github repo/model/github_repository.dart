import 'github_owner.dart';

class RemoteGitHubRepository {
  final int id;
  final String name;
  final String fullName;
  final RemoteGithubOwner owner;
  final String description;
  final String updatedAt;
  final String language;

  RemoteGitHubRepository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    required this.description,
    required this.updatedAt,
    required this.language,
  });

  factory RemoteGitHubRepository.fromJson(Map<String, dynamic> json) {
    return RemoteGitHubRepository(
        id: json['id'],
        name: json['name'] ?? '',
        fullName: json['full_name'] ?? '',
        owner: RemoteGithubOwner.fromJson(json['owner']),
        description: json['description'] ?? '',
        updatedAt: json['updated_at'] ?? '',
        language: json['language'] ?? '');
  }
}
