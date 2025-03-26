class InfoUserModel {
  String? id;
  String? username;
  String? lastName;
  String? email;
  bool? emailVerified;
  int? createdTimestamp;
  bool? enabled;
  bool? totp;
  List<String>? disableableCredentialTypes;
  List<String>? requiredActions;
  int? notBefore;
  Access? access;

  InfoUserModel(
      {this.id,
      this.username,
      this.lastName,
      this.email,
      this.emailVerified,
      this.createdTimestamp,
      this.enabled,
      this.totp,
      this.disableableCredentialTypes,
      this.requiredActions,
      this.notBefore,
      this.access});

  InfoUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    lastName = json['lastName'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    createdTimestamp = json['createdTimestamp'];
    enabled = json['enabled'];
    totp = json['totp'];
    disableableCredentialTypes =
        json['disableableCredentialTypes'].cast<String>();
    requiredActions = json['requiredActions'].cast<String>();
    notBefore = json['notBefore'];
    access =
        json['access'] != null ? new Access.fromJson(json['access']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['emailVerified'] = this.emailVerified;
    data['createdTimestamp'] = this.createdTimestamp;
    data['enabled'] = this.enabled;
    data['totp'] = this.totp;
    data['disableableCredentialTypes'] = this.disableableCredentialTypes;
    data['requiredActions'] = this.requiredActions;
    data['notBefore'] = this.notBefore;
    if (this.access != null) {
      data['access'] = this.access!.toJson();
    }
    return data;
  }
}

class Access {
  bool? manageGroupMembership;
  bool? view;
  bool? mapRoles;
  bool? impersonate;
  bool? manage;

  Access(
      {this.manageGroupMembership,
      this.view,
      this.mapRoles,
      this.impersonate,
      this.manage});

  Access.fromJson(Map<String, dynamic> json) {
    manageGroupMembership = json['manageGroupMembership'];
    view = json['view'];
    mapRoles = json['mapRoles'];
    impersonate = json['impersonate'];
    manage = json['manage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manageGroupMembership'] = this.manageGroupMembership;
    data['view'] = this.view;
    data['mapRoles'] = this.mapRoles;
    data['impersonate'] = this.impersonate;
    data['manage'] = this.manage;
    return data;
  }
}
