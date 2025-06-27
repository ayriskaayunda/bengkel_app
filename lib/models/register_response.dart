import 'auth_data.dart';

class RegisterResponse {
  final String? message;

  final AuthData? data;

  RegisterResponse({this.message, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
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
//model ini untuk memproses respon dari API saat pengguna melakukan registrasi 
//ketika user mendaftar akun ,server akan mengirimkan json yang isinya pesan sukses/eror message 