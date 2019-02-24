class Tokens {
  final AccessToken access;
  final RefreshToken refresh;

  Tokens({this.access, this.refresh});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    AccessToken access = AccessToken.fromJson(json);
    RefreshToken refresh = RefreshToken.fromJson(json);

    return Tokens(
      access: access,
      refresh: refresh,
    );
  }

}
class AccessToken {
  final String accessToken;

  AccessToken({this.accessToken});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    if (json['access_token'].isEmpty) {
      return null;
    }
    
    return AccessToken(
      accessToken: json['access_token'],
    );
  }
}
class RefreshToken {
  final String refreshToken;

  RefreshToken({this.refreshToken});

  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    if (json['refresh_token'].isEmpty) {
      return null;
    }

    return RefreshToken(
      refreshToken: json['refresh_token']
    );
  }
}