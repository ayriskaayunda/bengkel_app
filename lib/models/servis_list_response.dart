import 'servis.dart';

class ServisListResponse {
  final String? message;

  final List<Servis>? data;

  ServisListResponse({this.message, this.data});

  factory ServisListResponse.fromJson(Map<String, dynamic> json) {
    return ServisListResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Servis.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.map((e) => e.toJson()).toList()};
  }
}
//model ini didgunakan untuk menampung respon dari API yang mengirimkan daftar (list) data servis