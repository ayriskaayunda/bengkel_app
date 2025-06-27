import 'servis_status_data.dart';

class SingleServisStatusResponse {
  final String? message;

  final ServisStatusData? data;

  SingleServisStatusResponse({this.message, this.data});

  factory SingleServisStatusResponse.fromJson(Map<String, dynamic> json) {
    return SingleServisStatusResponse(
      message: json['message'] as String?,
      data: json['data'] != null
          ? ServisStatusData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
