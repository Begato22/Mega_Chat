import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  late String uId;
  late String? name;
  late String email;
  String? imgUrl;
  String? cover;
  String? phone;
  bool isEmailVerified = false;
  LoginMethod loginMethod = LoginMethod.normal;

  UserModel(
    this.uId,
    this.name,
    this.email,
    this.imgUrl,
    this.cover,
    this.phone,
  );
  UserModel.fromJson(Map<String, dynamic>? json) {
    uId = json!['uid'];
    name = json['name'];
    email = json['email'];
    imgUrl = json['imageUrl'];
    cover = json['cover'];
    phone = json['phone'];
  }
  UserModel.fromFacebookJson(Map<String, dynamic>? json) {
    uId = json!['id'];
    name = json['name'];
    email = json['email'];
    imgUrl = json['picture']['data']['url'];
  }
  UserModel.fromGoogleJson(GoogleSignInAccount? json) {
    uId = json!.id;
    name = json.displayName;
    email = json.email;
    imgUrl = json.photoUrl;
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'imgUrl': imgUrl,
      'isEmailVerified': isEmailVerified,
    };
  }
}

enum LoginMethod {
  normal,
  facebook,
  google,
}
