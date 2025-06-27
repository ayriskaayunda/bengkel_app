import 'servis.dart';

class CreateServisResponse {
  final String? message;

  final Servis? data;

  CreateServisResponse({this.message, this.data});

  factory CreateServisResponse.fromJson(Map<String, dynamic> json) {
    return CreateServisResponse(
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
//model data yang digunakan untuk menangani respon dari API saat pengguna membuat permintaan servis baru 
//digunakan untuk pengguna mengisi form servis dan mengirim ke server model ini akan menerima
// pesan status dari server dan data servis yang baru dibuat (data,berupa objek servis)