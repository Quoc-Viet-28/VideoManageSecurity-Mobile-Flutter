class PayLoad {
  int? exp;
  int? iat;
  String? jti;
  String? iss;
  String? aud;
  String? sub;
  String? typ;
  String? azp;
  String? sid;
  String? acr;
  List<String>? allowedOrigins;
  RealmAccess? realmAccess;
  ResourceAccess? resourceAccess;
  String? scope;
  bool? emailVerified;
  String? name;
  String? preferredUsername;
  String? familyName;
  String? email;

  PayLoad(
      {this.exp,
      this.iat,
      this.jti,
      this.iss,
      this.aud,
      this.sub,
      this.typ,
      this.azp,
      this.sid,
      this.acr,
      this.allowedOrigins,
      this.realmAccess,
      this.resourceAccess,
      this.scope,
      this.emailVerified,
      this.name,
      this.preferredUsername,
      this.familyName,
      this.email});

  PayLoad.fromJson(Map<String, dynamic> json) {
    exp = json['exp'];
    iat = json['iat'];
    jti = json['jti'];
    iss = json['iss'];
    aud = json['aud'];
    sub = json['sub'];
    typ = json['typ'];
    azp = json['azp'];
    sid = json['sid'];
    acr = json['acr'];
    allowedOrigins = json['allowed-origins'].cast<String>();
    realmAccess = json['realm_access'] != null
        ? new RealmAccess.fromJson(json['realm_access'])
        : null;
    resourceAccess = json['resource_access'] != null
        ? new ResourceAccess.fromJson(json['resource_access'])
        : null;
    scope = json['scope'];
    emailVerified = json['email_verified'];
    name = json['name'];
    preferredUsername = json['preferred_username'];
    familyName = json['family_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exp'] = this.exp;
    data['iat'] = this.iat;
    data['jti'] = this.jti;
    data['iss'] = this.iss;
    data['aud'] = this.aud;
    data['sub'] = this.sub;
    data['typ'] = this.typ;
    data['azp'] = this.azp;
    data['sid'] = this.sid;
    data['acr'] = this.acr;
    data['allowed-origins'] = this.allowedOrigins;
    if (this.realmAccess != null) {
      data['realm_access'] = this.realmAccess!.toJson();
    }
    if (this.resourceAccess != null) {
      data['resource_access'] = this.resourceAccess!.toJson();
    }
    data['scope'] = this.scope;
    data['email_verified'] = this.emailVerified;
    data['name'] = this.name;
    data['preferred_username'] = this.preferredUsername;
    data['family_name'] = this.familyName;
    data['email'] = this.email;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'exp: $exp, iat: $iat, jti: $jti, iss: $iss, aud: $aud, sub: $sub, typ: $typ, azp: $azp, sid: $sid, acr: $acr, allowedOrigins: $allowedOrigins, realmAccess: $realmAccess, resourceAccess: $resourceAccess, scope: $scope, emailVerified: $emailVerified, name: $name, preferredUsername: $preferredUsername, familyName: $familyName, email: $email';
  }
}

class RealmAccess {
  List<String>? roles;

  RealmAccess({this.roles});

  RealmAccess.fromJson(Map<String, dynamic> json) {
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roles'] = this.roles;
    return data;
  }
}

class ResourceAccess {
  RealmAccess? account;

  ResourceAccess({this.account});

  ResourceAccess.fromJson(Map<String, dynamic> json) {
    account = json['account'] != null
        ? new RealmAccess.fromJson(json['account'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    return data;
  }
}
