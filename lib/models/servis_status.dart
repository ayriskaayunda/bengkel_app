import 'dart:convert';

StatusServis statusServisFromJson(String str) =>
    StatusServis.fromJson(json.decode(str));

String statusServisToJson(StatusServis data) => json.encode(data.toJson());

class StatusServis {
  final String? message;
  final Data? data;

  StatusServis({this.message, this.data});

  factory StatusServis.fromJson(Map<String, dynamic> json) => StatusServis(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  final String? status;

  Data({this.status});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(status: json["status"]);

  Map<String, dynamic> toJson() => {"status": status};
}
// model untuk menangani data status dari servis yang dikirim atau diterima dari backend bentuk JSON
//menampilkan status seperti menunggu , di proses,selesasi