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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    data['password'] = this.password;
    data['chain_id'] = this.chainId;
    return data;
  }
}
