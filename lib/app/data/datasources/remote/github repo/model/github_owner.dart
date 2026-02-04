class RemoteGithubOwner {
  String login;
  String avatar;

  RemoteGithubOwner({required this.login, required this.avatar});

  factory RemoteGithubOwner.fromJson(Map<String, dynamic> json) {
    return RemoteGithubOwner(
        login: json['login'] ?? '', avatar: json['avatar_url'] ?? '');
  }
}
