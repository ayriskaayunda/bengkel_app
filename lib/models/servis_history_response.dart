import 'servis.dart';

class ServisHistoryResponse {
  final String? message;

  final List<Servis>? data;

  ServisHistoryResponse({this.message, this.data});

  factory ServisHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ServisHistoryResponse(
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
//model yang digunakan untuk menerima data riwayat servis dari API/backend
//untuk menampilkan daftar riwayat servis yang pernah dilakukan oleh pengguna
//menggunakan mapping List.map untuk parsing semua item