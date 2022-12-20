
class User {
  String? name;
  bool? is_verified;
  String? otp_code;
  String? otp_expires_at;
  String? email;
  int? id;
  String? phone;
  String? photo_path;
  String? created_at;
  String? occupation;
  String? gender;
  int? user_id;

  User({
    this.id = 0,
    this.name,
    this.email,
    this.phone,
    this.occupation,
    this.photo_path,
    this.otp_code,
    this.otp_expires_at,
    this.is_verified = false,
    this.gender,
    this.user_id = 0,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['user']['name'],
        id = json['id'],
        email = json['user']['email'],
        occupation = json['occupation'],
        gender = json['gender'] == 0? 'Perempuan' : 'Laki-laki',
        phone = json['phone'],

        is_verified = json['is_verified'] == 1 ? true : false,
        otp_code = json['otp_code'].toString() ?? '',
        otp_expires_at = json['otp_expires_at'],
        photo_path = json['photo_path'],
        created_at = json['pivot'] != null ? json['pivot']['created_at'] : null,
        user_id = json['user_id'];


}
