import '../utils/http.dart';

// 获取用户信息
Future fetchUsers(String username) async {
  return await dio.get('/users/$username').then((res) => res.data);
}

class UserModel {
  UserModel({
    this.username,
    this.avatarUrl,
    this.location,
    this.createdAt,
    this.email,
  });

  String username;
  String avatarUrl;
  String location;
  String createdAt;
  String email;
  String blog;
  int followers;
  int following;
  int publicRepos;
  int publicGists;

  UserModel.fromJson(Map json) {
    username = json['login'];
    avatarUrl = json['avatar_url'];
    createdAt = json['created_at'];
    location = json['location'] ?? 'none';
    email = json['email'] ?? 'none';
    blog = json['blog'] ?? 'none';
    followers = json['followers'];
    following = json['following'];
    publicRepos = json['public_repos'];
    publicGists = json['public_gists'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'avatarUrl': avatarUrl,
      'location': location,
      'createdAt': createdAt,
      'email': email,
      'blog': blog,
      'followers': followers,
      'following': following,
      'publicRepos': publicRepos,
      'publicGists': publicGists,
    };
  }
}
