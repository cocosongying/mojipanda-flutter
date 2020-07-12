class UserInfoModel {
  UserInfo userInfo;
  String token;
  UserInfoModel.fromJson(Map<String, dynamic> json)
      : userInfo = UserInfo.fromJson(json['userInfo']),
        token = json['token'];
}

class UserInfo {
  int id;
  String username;
  String nickname;
  String avatar;
  String description;
  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        nickname = json['nickname'],
        avatar = json['avatar'],
        description = json['description'];
}
