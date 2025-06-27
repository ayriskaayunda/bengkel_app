import 'auth_data.dart';

class LoginResponse {
  final String? message;

  final AuthData? data;

  LoginResponse({this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? AuthData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
//model ini untuk memproses respon dari API saat pengguna login
//memudahkan komunikasi dengan backend dan menyimpan ke local storage 