class AuthResponseModel {
  String? accessToken;
  int? expiresIn;
  String? refreshToken;
  String? tokenType;

  AuthResponseModel(
      {this.accessToken, this.expiresIn, this.refreshToken, this.tokenType});

  AuthResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
      'token_type': tokenType,
    };
  }
}
