class AuthenModel {
  String? userName;
  String? updatedAt;
  String? token;
  String? password;
  int? chainId;

  AuthenModel(
      {this.userName, this.updatedAt, this.token, this.password, this.chainId});

  AuthenModel.fromJson(Map<String, dynamic> json) {
    userName = json['data']['userName'];
    updatedAt = json['data']['updated_at'];
    token = json['data']['token'];
    password = json['data']['password'];
    chainId = json['data']['chain_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    data['password'] = password;
    data['chain_id'] = chainId;
    return data;
  }
}
