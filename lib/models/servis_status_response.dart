import 'servis.dart';

class UpdateServisStatusResponse {
  final String? message;

  final Servis? data;

  UpdateServisStatusResponse({this.message, this.data});

  factory UpdateServisStatusResponse.fromJson(Map<String, dynamic> json) {
    return UpdateServisStatusResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? Servis.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
//model ini untuk menangani respon dari server saat aplikasi mengupdate status servis (menunggu jadi di proses atau selesai)
//untuk membaca hasil respon dari API setelah update status servis