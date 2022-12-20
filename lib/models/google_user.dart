class GoogleUser {
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;
  String? token;

  GoogleUser(
      {this.displayName, this.email, this.id, this.photoUrl, this.token});

  GoogleUser.fromJson(Map<String, dynamic> json) {
    displayName = json["displayName"];
    email = json["email"];
    id = json["id"];
    photoUrl = json["photoUrl"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["displayName"] = this.displayName;
    data["email"] = this.email;
    data["id"] = this.id;
    data["photoUrl"] = this.photoUrl;
    data["token"] = this.token;
    return data;
  }
}