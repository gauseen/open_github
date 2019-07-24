import '../utils/http.dart';

Future fetchRepoInfo(String repoFullName) async {
  return await dio.get('/repos/$repoFullName').then((res) => res.data);
}

class RepoInfoModel {
  RepoInfoModel({
    this.issues,
    this.stargazers,
    this.watchers,
    this.forks,
  });

  int issues;
  int stargazers;
  int watchers;
  int forks;

  RepoInfoModel.fromJson(Map json) {
    issues = json['open_issues_count'] ?? 0;
    stargazers = json['stargazers_count'];
    watchers = json['watchers_count'];
    forks = json['forks_count'];
  }

  toJson() {
    return RepoInfoModel(issues: issues, stargazers: stargazers, watchers: watchers, forks: forks);
  }
}