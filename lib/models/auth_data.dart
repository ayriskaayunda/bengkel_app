import 'user.dart';

class AuthData {
  /// ini adalah token autentikasi yang dikirim oleh backend setelah login berhasil
  final String? token;

  final User? user;

  AuthData({this.token, this.user});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'] as String?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this AuthData object to a JSON map.
  Map<String, dynamic> toJson() {
    return {'token': token, 'user': user?.toJson()};
  }
}
