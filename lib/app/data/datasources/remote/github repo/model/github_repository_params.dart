import 'package:pubchem/app/utils/constants.dart';

class GitHubRepositoryParams {
  final String sortBy;
  final int pageNo;

  GitHubRepositoryParams({required this.sortBy, required this.pageNo});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q'] = searchKeyword;
    data['per_page'] = perPage;
    data['order'] = orderBy;
    data['page'] = pageNo;
    data['sort'] = sortBy;

    return data;
  }
}
